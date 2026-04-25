package com.prohire.controller;
import com.prohire.dao.UsuarioDAO;
import com.prohire.model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setNombre(request.getParameter("nombre"));
        u.setEmail(request.getParameter("email"));
        u.setPassword(request.getParameter("password"));
        u.setRol(request.getParameter("rol"));
        u.setProfesion(request.getParameter("profesion"));
        u.setTelefono(request.getParameter("telefono"));
        
        if (new UsuarioDAO().registrar(u)) response.getWriter().print("<h1>✅ Usuario Registrado</h1><a href='registro.jsp'>Volver</a>");
        else response.getWriter().print("<h1>❌ Error</h1>");
    }
}