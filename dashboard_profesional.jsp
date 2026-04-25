package com.prohire.dao;

import com.prohire.model.Postulacion;
import com.prohire.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostulacionDAO {

    // 1. Guardar la postulación (Cuando el profesional le da al botón verde)
    public boolean registrarPostulacion(Postulacion p) {
        String sql = "INSERT INTO postulaciones (id_profesional, id_vacante, estado) VALUES (?, ?, ?)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, p.getId_profesional());
            ps.setInt(2, p.getId_vacante());
            ps.setString(3, "ENVIADA");

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error DAO Postulacion: " + e.getMessage());
            return false;
        }
    }

    // 2. Traer la lista de candidatos a las vacantes de esta empresa específica
    public List<Postulacion> listarPorEmpresa(int idEmpresa) {
        List<Postulacion> lista = new ArrayList<>();
        
        // Consulta avanzada usando JOIN para traer el nombre del usuario y el cargo en una sola pasada
        String sql = "SELECT p.*, v.cargo, u.nombre FROM postulaciones p " +
                     "JOIN vacantes v ON p.id_vacante = v.id_vacante " +
                     "JOIN usuarios u ON p.id_profesional = u.id_usuario " +
                     "WHERE v.id_empresa = ?";
                     
        try (Connection con = Conexion.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, idEmpresa);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Postulacion pos = new Postulacion();
                pos.setId_postulacion(rs.getInt("id_postulacion"));
                pos.setEstado(rs.getString("estado"));
                
                // Guardamos la info combinada (Nombre - Cargo) en este campo temporal para mostrarlo fácil en la vista
                pos.setFecha_postulacion(rs.getString("nombre") + " - " + rs.getString("cargo"));
                
                lista.add(pos);
            }
        } catch (SQLException e) { 
            System.err.println("Error al listar candidatos: " + e.getMessage());
        }
        return lista;
    }

    // 3. Cambiar estado a ACEPTADO o RECHAZADO (Botones del panel de empresa)
    public boolean actualizarEstado(int id, String estado) {
        String sql = "UPDATE postulaciones SET estado = ? WHERE id_postulacion = ?";
        try (Connection con = Conexion.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, estado);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) { 
            System.err.println("Error al actualizar estado: " + e.getMessage());
            return false; 
        }
    }
}