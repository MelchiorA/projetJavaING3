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
public class ProfesseurDAO extends DAO<Professeur> {
  public ProfesseurDAO(Connection conn) {
    super(conn);
  }

  public boolean create(Professeur obj) {
    return false;
  }

  public boolean delete(Professeur obj) {
    return false;
  }

  public boolean update(Professeur obj) {
    return false;
  }
   
  public Professeur find(int id) {
    Professeur professeur = new Professeur();            
    try {
      ResultSet result = this.connect.createStatement(
        ResultSet.TYPE_SCROLL_INSENSITIVE, 
        ResultSet.CONCUR_READ_ONLY
      ).executeQuery(
        "SELECT * FROM professeur "+
        "LEFT JOIN j_mat_prof ON jmp_prof_k = prof_id " + 
        "AND prof_id = "+ id +
        " INNER JOIN matiere ON jmp_mat_k = mat_id"
      );
      if(result.first()){
        professeur = new Professeur(id, result.getString("prof_nom"), result.getString("prof_prenom"));
        result.beforeFirst();
        MatiereDAO matDao = new MatiereDAO(this.connect);
            
        while(result.next())
          professeur.addMatiere(matDao.find(result.getInt("mat_id")));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return professeur;
  }

  public boolean update(Professeur obj) {
    return false;
  }
}