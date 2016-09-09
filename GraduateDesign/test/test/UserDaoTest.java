package test;

import static org.junit.Assert.*;

import org.junit.Test;

import dao.*;
import entity.User;

public class UserDaoTest {
    IUserDao dao=new UserDaoImpl();
	
    @Test
	public void testFindByeMail(){
		System.out.println( dao.findByeMail(null) );
	}
}
