package com.prohire.dao;

import com.prohire.model.Usuario;
import com.prohire.util.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // <- ESTE ERA EL QUE FALTABA
import java.sql.SQLException;

public class UsuarioDAO {

    // 1. Método para REGISTRAR (El que ya funcionaba)
    public boolean registrar(Usuario u) {
        String sql = "INSERT INTO usuarios (nombre, email, password, rol, profesion, telefono) VALUES (?,?,?,?,?,?)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRol());
            ps.setString(5, u.getProfesion());
            ps.setString(6, u.getTelefono());

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("❌ Error DAO Usuario (Registro): " + e.getMessage());
            return false;
        }
    }

    // 2. Método para VALIDAR EL LOGIN (El nuevo)
    public Usuario validar(String email, String pass) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, pass);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setEmail(rs.getString("email"));
                u.setRol(rs.getString("rol"));
                u.setProfesion(rs.getString("profesion"));
                return u;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error Login: " + e.getMessage());
        }
        return null;
    }
}