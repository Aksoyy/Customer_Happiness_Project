package com.example.customerquestion;
/*Kullanıcıdan alınan parametlerin web servise gitmesi icin
 *gerekli metodları belirtmektedir. Bu metodları kullanırken
 *web servisi açmayı unutmamalıyız.
 */
public interface IOperations
{
	public LoginResult Login(LoginInput input);
}
