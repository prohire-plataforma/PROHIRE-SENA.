package com.prohire.model;

public class Postulacion {
    private int id_postulacion;
    private int id_profesional;
    private int id_vacante;
    private String estado; // 'ENVIADA', 'ACEPTADO', 'RECHAZADO'
    private String fecha_postulacion;

    public Postulacion() {}

    // Getters y Setters
    public int getId_postulacion() { return id_postulacion; }
    public void setId_postulacion(int id_postulacion) { this.id_postulacion = id_postulacion; }

    public int getId_profesional() { return id_profesional; }
    public void setId_profesional(int id_profesional) { this.id_profesional = id_profesional; }

    public int getId_vacante() { return id_vacante; }
    public void setId_vacante(int id_vacante) { this.id_vacante = id_vacante; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getFecha_postulacion() { return fecha_postulacion; }
    public void setFecha_postulacion(String fecha_postulacion) { this.fecha_postulacion = fecha_postulacion; }
}