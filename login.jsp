package com.prohire.dao;

import com.prohire.model.Vacante;
import com.prohire.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VacanteDAO {

    // 1. Registrar nueva vacante (Para la empresa)
    public boolean registrar(Vacante v) {
        String sql = "INSERT INTO vacantes (id_empresa, cargo, salario, modalidad, tipo_contrato, ubicacion, descripcion) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = Conexion.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, v.getId_empresa());
            ps.setString(2, v.getCargo());
            ps.setString(3, v.getSalario());
            ps.setString(4, v.getModalidad());
            ps.setString(5, v.getTipo_contrato());
            ps.setString(6, v.getUbicacion());
            ps.setString(7, v.getDescripcion());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al registrar Vacante: " + e.getMessage());
            return false;
        }
    }

    // 2. Listar TODAS las vacantes (Para el dashboard del profesional)
    public List<Vacante> listar() {
        List<Vacante> lista = new ArrayList<>();
        String sql = "SELECT * FROM vacantes ORDER BY fecha_publicacion DESC";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Vacante v = new Vacante();
                v.setId_vacante(rs.getInt("id_vacante"));
                v.setId_empresa(rs.getInt("id_empresa"));
                v.setCargo(rs.getString("cargo"));
                v.setSalario(rs.getString("salario"));
                v.setModalidad(rs.getString("modalidad"));
                v.setTipo_contrato(rs.getString("tipo_contrato"));
                v.setUbicacion(rs.getString("ubicacion"));
                v.setDescripcion(rs.getString("descripcion"));
                lista.add(v);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar vacantes: " + e.getMessage());
        }
        return lista;
    }

    // 3. Listar SOLO las vacantes de una empresa (Para el dashboard de empresa)
    public List<Vacante> listarPorEmpresa(int idEmpresa) {
        List<Vacante> lista = new ArrayList<>();
        String sql = "SELECT * FROM vacantes WHERE id_empresa = ? ORDER BY fecha_publicacion DESC";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idEmpresa);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Vacante v = new Vacante();
                    v.setId_vacante(rs.getInt("id_vacante"));
                    v.setCargo(rs.getString("cargo"));
                    v.setSalario(rs.getString("salario"));
                    v.setModalidad(rs.getString("modalidad"));
                    v.setUbicacion(rs.getString("ubicacion"));
                    lista.add(v);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar por empresa: " + e.getMessage());
        }
        return lista;
    }

    // 4. Eliminar vacante (Para el botón borrar del dashboard empresa)
    public boolean eliminar(int id) {
        String sql = "DELETE FROM vacantes WHERE id_vacante = ?";
        try (Connection con = Conexion.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) { 
            System.err.println("Error al eliminar vacante: " + e.getMessage());
            return false; 
        }
    }
}