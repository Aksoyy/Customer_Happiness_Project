package project.version;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

public class Customer {
	String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	String DATABASE_URL = "jdbc:sqlserver://localhost;database=Customer;";
	String USERNAME = "java";
	String PASSWORD = "123456";

	public boolean createUser(String userName, String password) {
		boolean result = false;
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			String selectQuery = "select count(*) AS TOTAL from User_Login where userName = '" + userName
					+ "' and Logical_delete_key is null";
			ResultSet countResult = statement.executeQuery(selectQuery);
			if (countResult.next()) {
				if (countResult.getInt(1) > 0) {
					return result;
				}
			}
			String insertQuery = "insert into User_login(Username,Password,Statu,CreationDate) values(?,?,?,SYSDATETIME())";
			//statement.executeUpdate(insertQuery);
			/*Değerleri kontrol ettikten sonra aktarma işlemi için kullanılmaktadır */
			PreparedStatement pstmt = connect.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, userName);
			pstmt.setString(2, password);
			pstmt.setString(3, "AKTIF");
			/*java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			pstmt.setDate(4, date);*/
			pstmt.executeUpdate();

			connect.close();
			statement.close();

			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return result;
	}

	public void userPassive(String sessionKey) {
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			/*
			 * Parametre olarak alınan sessionkey ile kullanıcının User_session_Id değeri
			 * bulunmaktadır
			 */
			String loginIdQuery = "select User_login_Id from User_Session" + " where Session_key = '" + sessionKey
					+ "'";
			ResultSet countResult = statement.executeQuery(loginIdQuery);

			int userId = 0;
			if (countResult.next())
				if (countResult.getInt(1) > 0) {
					userId = countResult.getInt(1);
				}

			/* Kullanıcının durumunu değiştirmeyi sağlayan sorgudur */
			String deleteQuery = "UPDATE User_Login Set Statu='PASIF',updatedate=SYSDATETIME()"
					+ " where User_login_Id=" + userId + "";
			statement.executeUpdate(deleteQuery);

			connect.close();
			statement.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public void userLogout(String sessionKey) {
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			/*
			 * Parametre olarak alınan sessionkey ile kullanıcının User_session_Id değeri
			 * bulunmaktadır
			 */
			String sessionIdQuery = "select User_session_Id from User_Session " + "where Session_key = '" + sessionKey
					+ "'";
			ResultSet countResult = statement.executeQuery(sessionIdQuery);

			int userSessionId = 0;
			if (countResult.next())
				if (countResult.getInt(1) > 0) {
					userSessionId = countResult.getInt(1);
				}

			/* Kullanıcının çıkış yapmasını sağlayan sorgudur */
			String userLogout = "update user_session set logical_delete_key = " + userSessionId
					+ ", updatedate=SYSDATETIME() where session_Key = '" + sessionKey + "'";
			statement.executeUpdate(userLogout);

			connect.close();
			statement.close();
		}

		catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public String userLogin(String userName, String password) {
		String sessionKey = null;
		try {
			/* Veritabanı ile bağlantı noktasıdır */
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			/*
			 * Parametreden alınan değerde kullanıcının olmasını ve aktif olmasını kontrol
			 * eden sorgudur
			 */
			String selectQuery = "select user_login_Id from user_login where username='" + userName + "' and Password='"
					+ password + "' and logical_delete_key is null";
			ResultSet countResult = statement.executeQuery(selectQuery);

			/*
			 * Sorgudan gelen değerleri next ile ilerletilerek, o kullanıcıya ait eski
			 * sessionkey kayıtlarını silip, yeni sessionkey tasarlanmaktadır
			 */
			if (countResult.next()) {
				if (countResult.getInt(1) > 0) {
					int userLoginId = countResult.getInt(1);

					LoginAllDelete(userLoginId);

					UUID uuid = UUID.randomUUID();
					sessionKey = uuid.toString();

					String insertQuery = "INSERT INTO User_Session(user_login_Id, session_key, CreationDate)"
							+ " VALUES (?,?,SYSDATETIME())";
					//statement.executeUpdate(insertQuery);
					
					/*Değerleri kontrol ettikten sonra aktarma işlemi için kullanılmaktadır */
					PreparedStatement pstmt = connect.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
					pstmt.setInt(1, userLoginId);
					pstmt.setString(2, sessionKey);
					/*java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
					pstmt.setDate(4, date);*/
					pstmt.executeUpdate();
				}
			}
			connect.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return sessionKey;
	}

	private void LoginAllDelete(long userLoginId) {
		try {
			/* Veritabanı ile bağlantı noktasıdır */
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			/*
			 * Parametre olarak alınan değerdeki kullanıcıyı ve bu kullacının aktif olması
			 * durumunda sessionkey değerlerini döndürmektedir
			 */
			String userSessionAll = "SELECT User_session_Id from User_Session where Logical_delete_key is null"
					+ " and User_login_Id =" + userLoginId;
			ResultSet countResult = statement.executeQuery(userSessionAll);

			/* Sessionkey değerleri önce bir liste içerisine aktarılmaktadır */
			List<Integer> userSessionIdList = new ArrayList<Integer>();
			while (countResult.next() && countResult.getInt(1) > 0) {
				userSessionIdList.add(countResult.getInt(1));
			}

			/*
			 * Iterator kullanılarak sessionkey'lerin logical_delete_key değerleri Null
			 * değerinden userSessionId değerine atanmaktadır
			 */
			Iterator<Integer> iteratorList = userSessionIdList.iterator();
			while (iteratorList.hasNext()) {
				Integer userSessionId = iteratorList.next();
				String userSessionUpdate = "update user_session set logical_delete_key = " + userSessionId
						+ ", updatedate= SYSDATETIME() where user_session_Id =" + userSessionId;
				statement.executeUpdate(userSessionUpdate);
			}

			connect.close();
			statement.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public boolean createQuestion(String sessionKey, String question, String kind, String s1, String s2, String s3,
			String s4) {
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			/* Parametre olarak alınan sessionkey ile kullanıcının User_login_Id değeri bulunmaktadır */
			String userIdQuery = "select User_login_Id from User_Session " + "where Session_key = '" + sessionKey
					+ "' and Logical_delete_key is null";
			ResultSet countResult = statement.executeQuery(userIdQuery);
			int userLoginId = 0;
			if (countResult.next())
				if (countResult.getInt(1) > 0) {
					userLoginId = countResult.getInt(1);
				}

			/* Sorunun tipinin id numarasını bulmayı sağlayan sorgudur */
			String questionIdQuery = "select Question_Type_Id from Question_Type" + " where Type_Name='" + kind + "'";
			ResultSet countResult2 = statement.executeQuery(questionIdQuery);
			int questionTypeId = 0;
			if (countResult2.next())
				if (countResult2.getInt(1) > 0) {
					questionTypeId = countResult2.getInt(1);
				}

			/* Soruyu ekleme sorgusunu belirtir */
			String insertQuery = "insert into "
					+ "User_Question(Question,Question_Type_Id,User_Login_Id,CreationDate) values(?,?,?,SYSDATETIME())";
			
			/*Değerleri kontrol ettikten sonra aktarma işlemi için kullanılmaktadır */
			PreparedStatement pstmt = connect.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, question);
			pstmt.setInt(2, questionTypeId);
			pstmt.setInt(3, userLoginId);
			/*java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			pstmt.setDate(4, date);*/
			pstmt.executeUpdate();
			
			/* Sorgudan dönen değeri tutmayı sağlayan yapıdır */
			int questionId = -1;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs != null && rs.next()) {
				questionId = rs.getInt(1);
			}

			/* Sorunun seçeneceklerinin eklendiği sorguyu belirtir */
			String insertQuery2 = "insert into"
					+ " User_Answer(User_Question_Id,Section_A,Section_B,Section_C,Section_D,CreationDate) values(?,?,?,?,?,?)";
			
			/*Değerleri kontrol ettikten sonra aktarma işlemi için kullanılmaktadır */
			PreparedStatement pstmt2 = connect.prepareStatement(insertQuery2, Statement.RETURN_GENERATED_KEYS);
			java.sql.Date date2 = new java.sql.Date(Calendar.getInstance().getTime().getTime());
			pstmt2.setInt(1, questionId);
			pstmt2.setString(2, s1);
			pstmt2.setString(3, s2);
			pstmt2.setString(4, s3);
			pstmt2.setString(5, s4);
			pstmt2.setDate(6, date2);
			pstmt2.executeUpdate();
			//statement.executeUpdate(insertQuery2);

			connect.close();
			statement.close();

			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateQuestion(String sessionKey, int QuestionId, String nQuestion, String nkind, 
			                      String ns1, String ns2, String ns3, String ns4)
	{
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();

			int userLoginId = validSessionKey(sessionKey);
			
			/*String updateQuery = "UPDATE User_Question, User_Answer, Question_Type SET User_Question.Question='"+nQuestion+"', "
							+ "Question_Type.Type_Name='"+nkind+"', User_Answer.Section_A='"+ns1+"', User_Answer.Section_B='"+ns2+"', "
							+ "User_Answer.Section_C='"+ns3+"', User_Answer.Section_D='"+ns4+"', "
							+ "User_Question.UpdateDate=SYSDATETIME(), User_Answer.UpdateDate=SYSDATETIME(), Question_Type.UpdateDate=SYSDATETIME() "
								+ "where User_Question.User_Question_Id = User_Answer.User_Question_Id "
								+ "and User_Question.Question_Type_Id = Question_Type.Question_Type_Id "
								+ "and User_Answer.Logical_Delete_Key IS NULL "
								+ "and User_Question.Logical_delete_key IS NULL "
								+ "and Question_Type.Logical_Delete_Key IS NULL "
								+ "and User_Question.User_Login_Id="+userLoginId+" "
								+ "and User_Question.User_Question_Id="+QuestionId+"";*/
			String searchQuery = "Select Question_Type_Id from Question_Type "
									+ "where Type_Name='"+nkind+"'";
			ResultSet result = statement.executeQuery(searchQuery);
			int typeId = 0;
			if (result.next())
				if (result.getInt(1) > 0) {
					typeId = result.getInt(1);
				}
	
			String updateQuery = "UPDATE User_Question SET Question='"+nQuestion+"', Question_Type_Id="+typeId+", "
									+ "UpdateDate=SYSDATETIME() where User_Login_Id="+userLoginId+" and "
											+ "User_Question_Id="+QuestionId+" and Logical_delete_key IS NULL";
			statement.executeUpdate(updateQuery);
			
			String updateQuery2 = "UPDATE User_Answer SET Section_A='"+ns1+"', Section_B='"+ns2+"', "
										+ "Section_C='"+ns3+"', Section_D='"+ns4+"', UpdateDate=SYSDATETIME() "
												+ "where User_Question_Id="+QuestionId+" and Logical_Delete_Key IS NULL";
			statement.executeUpdate(updateQuery2);
			
			/*String updateQuery3 = "UPDATE Question_Type SET Type_Name='"+nkind+"', UpdateDate=SYSDATETIME() "
									+ "where User_Question_Id="+QuestionId+" and Logical_Delete_Key IS NULL";
			statement.executeUpdate(updateQuery3);*/
			
			connect.close();
			statement.close();
			return true;
		}catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public boolean changePassword(String sessionKey, String newPassword)
	{
		int loginId = validSessionKey(sessionKey);
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();
			
			if( loginId > 0 )
			{
				String sessionIdQuery = "UPDATE User_Login SET Password='"+newPassword+"', "
						+ "UpdateDate=SYSDATETIME() "
						+ "where User_login_Id="+loginId+" and "
						+ "Logical_Delete_Key is null and statu ='AKTIF'";
				statement.executeUpdate(sessionIdQuery);
				
				connect.close();
				statement.close();
				return true;
				//ResultSet countResult = statement.executeQuery(sessionIdQuery);
				//UPDATE dbo.user_password SET Password=@Password,update_date=@UpdateDate where User_Login_Id = {0}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public QuestionInfo[] questionList(String sessionKey) {
		List<QuestionInfo> infoList = new ArrayList<QuestionInfo>();
		int userLoginId = validSessionKey(sessionKey);
		if (userLoginId > 0) {
			try {
				Class.forName(JDBC_DRIVER);
				Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
				Statement statement = connect.createStatement();

				String query = "SELECT uq.User_Question_Id, uq.Question, ua.Section_A, ua.Section_B, ua.Section_C, ua.Section_D, qt.Type_Name as Question_type "
						+ " FROM User_Login ul,User_Question uq,User_Answer ua, Question_Type qt "
						+ " WHERE ul.User_login_Id = uq.User_Login_Id" + "	  AND ul.User_login_Id = " + userLoginId
						+ "      AND qt.Question_Type_Id = uq.Question_Type_Id"
						+ "      AND uq.User_Question_Id = ua.User_Question_Id"
						+ "      AND ul.Logical_Delete_Key IS NULL" 
						+ "      AND ua.Logical_Delete_Key IS NULL"
						+ "      AND uq.Logical_delete_key IS NULL;";
				ResultSet resultList = statement.executeQuery(query);

				while (resultList.next()) {
					QuestionInfo info = new QuestionInfo();
					info.QuestionId = resultList.getInt("User_Question_Id");
					info.Question = resultList.getString("Question");
					info.SectionA = resultList.getString("Section_A");
					info.SectionB = resultList.getString("Section_B");
					info.SectionC = resultList.getString("Section_C");
					info.SectionD = resultList.getString("Section_D");
					info.QuestionType = resultList.getString("Question_type");
					infoList.add(info);

				}
				connect.close();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		QuestionInfo[] arrList = null;
		int size = infoList.size();
		if (size > 0) {
			arrList = new QuestionInfo[size];
			arrList = infoList.toArray(arrList);
		}
		return arrList;
	}

	private int validSessionKey(String sessionKey) {
		int userLoginId = -1;
		try {
			Class.forName(JDBC_DRIVER);
			Connection connect = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);
			Statement statement = connect.createStatement();
			String sessionIdQuery = "select user_login_Id from user_session where logical_delete_key is null and "
					+ "session_key = '" + sessionKey + "'";
			ResultSet countResult = statement.executeQuery(sessionIdQuery);
			if (countResult.next())
				if (countResult.getInt(1) > 0) {
					userLoginId = countResult.getInt(1);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return userLoginId;
	}
}