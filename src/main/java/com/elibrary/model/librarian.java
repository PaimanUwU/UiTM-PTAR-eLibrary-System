/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.elibrary.model;

/**
 *
 * @author AdamZ
 */
public class librarian {
    String id;
    String supervisor_id;
    String name;
    String position;
    
    public librarian(String id, String supervisor_id, String name, String position){
        this.id = id;
        this.supervisor_id = supervisor_id;
        this.name = name;
        this.position = position;
    }
}
