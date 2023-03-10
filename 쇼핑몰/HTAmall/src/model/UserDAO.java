package model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import org.springframework.stereotype.Repository;

import model.domain.entity.User;
import util.DBUtil;

@Repository
public class UserDAO {

	public void createUser(User user) throws Exception {
		EntityManager em = DBUtil.getEntityManager();
		EntityTransaction tx = em.getTransaction();

		try {
			tx.begin();

			user.setUserDate(new Date());
			em.persist(user);

			tx.commit();
		} finally {
			em.close();
		}
	}

	public boolean checkId(String userId) throws Exception {
		EntityManager em = DBUtil.getEntityManager();
		
		Long count = null;
		try {
			count = em.createQuery("select count(u) from User u where u.userId = :userId", Long.class)
					.setParameter("userId", userId)
					.getSingleResult();
		} finally {
			em.close();
		}
		
		return count == 0;
	}
	
	public boolean validateUser(String userId, String userPassword) throws Exception{
		EntityManager em = DBUtil.getEntityManager();
		
		Long count = null;
		try {
			count = em.createQuery("select count(u) from User u where u_id = :u_id and u_password = :u_password", Long.class)
					.setParameter("u_id", userId)
					.setParameter("u_password", userPassword)
					.getSingleResult();
			
		} finally {
			em.close();			
		}
		
		return count == 1;
	}
	
	public User selectOneUser(String userId) throws Exception{
		EntityManager em = DBUtil.getEntityManager();
		
		User user = null;
		try {
			user = (User) em.createQuery("select u from User u where u_id = :u_id")
					.setParameter("u_id", userId)
					.getSingleResult();
			
		}finally {
			em.close();
		}
		
		return user;
	}

}