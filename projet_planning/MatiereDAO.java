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
public class MatiereDAO extends DAO<Matiere> {
  public MatiereDAO(Connection conn) {
    super(conn);
  }

  public boolean create(Matiere obj) {
    return false;
  }

  public boolean delete(Matiere obj) {
    return false;
  }

  public boolean update(Matiere obj) {
    return false;
  }

  public Matiere find(int id) {
    Matiere matiere = new Matiere();  

    try {
      ResultSet result = this.connect.createStatement(
        ResultSet.TYPE_SCROLL_INSENSITIVE, 
        ResultSet.CONCUR_READ_ONLY
      ).executeQuery("SELECT * FROM matiere WHERE mat_id = " + id);
        if(result.first())
          matiere = new Matiere(id, result.getString("mat_nom"));         
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return matiere;
  }
}
