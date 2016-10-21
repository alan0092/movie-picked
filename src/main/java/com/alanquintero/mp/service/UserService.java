/*******************************************************
 * Copyright (C) 2016 Alan Quintero <alan_q_b@hotmail.com>
 * 
 * This file is part of My Personal Project: "Movie Pick".
 * 
 * "Movie Pick" can not be copied and/or distributed without the express
 * permission of Alan Quintero.
 *******************************************************/
package com.alanquintero.mp.service;

import java.util.List;

import com.alanquintero.mp.entity.User;

/**
 * @class UserService.java
 * @purpose Interface of Service Layer for User Transactions.
 */
public interface UserService {

    /**
     * @return List_User
     */
    public List<User> getAllUsers();

    /**
     * @param int
     * @return User
     */
    public User searchUserById(int userId);

    /**
     * @param int
     * @return User
     */
    public User searchUserWithReviewsById(int userId);

    /**
     * @param User
     */
    public void saveUser(User user);

    /**
     * @param String
     * @return User
     */
    public User searchUserWithReviewsByName(String userName);

    /**
     * @param int
     */
    public void deleteUser(int userId);

    /**
     * @param String
     * @return User
     */
    public User searchUserByName(String userName);

    /**
     * @param String
     * @return User
     */
    public User searchUserByEmail(String userEmail);

}
