/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
https://openclassrooms.com/fr/courses/26832-apprenez-a-programmer-en-java/26830-liez-vos-tables-avec-des-objets-java-le-pattern-dao
 */

/**
 *
 * @author Admin
 */
package com.sdz.dao.implement;
//CTRL + SHIFT + O pour générer les imports
public class EleveDAO extends DAO<Eleve> {
  public EleveDAO(Connection conn) {
    super(conn);
  }

  public boolean create(Eleve obj) {
    return false;
  }

  public boolean delete(Eleve obj) {
    return false;
  }
   
  public boolean update(Eleve obj) {
    return false;
  }
   
  public Eleve find(int id) {
    Eleve eleve = new Eleve();      
      
    try {
      ResultSet result = this.connect.createStatement(
        ResultSet.TYPE_SCROLL_INSENSITIVE,
        ResultSet.CONCUR_READ_ONLY).executeQuery("SELECT * FROM eleve WHERE elv_id = " + id);
      if(result.first())
        eleve = new Eleve(
          id,
          result.getString("elv_nom"),
          result.getString("elv_prenom"
        ));         
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return eleve;
  }
}