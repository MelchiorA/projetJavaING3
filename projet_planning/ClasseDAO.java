/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Admin
 */
package com.sdz.dao.implement;
//CTRL + SHIFT + O pour générer les imports
public class ClasseDAO extends DAO<Classe> {
  public ClasseDAO(Connection conn) {
    super(conn);
  }

  public boolean create(Classe obj) {
    return false;
  }

  public boolean delete(Classe obj) {
    return false;
  }
   
  public boolean update(Classe obj) {
    return false;
  }

  public Classe find(int id) {
    Classe classe = new Classe();            
    try {
      ResultSet result = this.connect.createStatement(
        ResultSet.TYPE_SCROLL_INSENSITIVE, 
        ResultSet.CONCUR_READ_ONLY
      ).executeQuery("SELECT * FROM classe WHERE cls_id = " + id); 

      if(result.first()){
        classe = new Classe(id, result.getString("cls_nom"));

        result = this.connect.createStatement().executeQuery(
          "SELECT prof_id, prof_nom, prof_prenom from professeur " +
          "INNER JOIN j_mat_prof ON prof_id = jmp_prof_k " +
          "INNER JOIN j_cls_jmp ON jmp_id = jcm_jmp_k AND jcm_cls_k = " + id
        );

        ProfesseurDAO profDao = new ProfesseurDAO(this.connect);

        while(result.next())             
          classe.addProfesseur(profDao.find(result.getInt("prof_id")));

        EleveDAO eleveDao = new EleveDAO(this.connect);
        result = this.connect.createStatement().executeQuery(
          "SELECT elv_id, elv_nom, elv_prenom FROM eleve " +
          "INNER JOIN classe ON elv_cls_k = cls_id AND cls_id = " + id
        );

        while(result.next())
          classe.addEleve(eleveDao.find(result.getInt("elv_id")));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return classe;
  }
}