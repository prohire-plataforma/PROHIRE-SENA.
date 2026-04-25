package com.prohire.controller;

import com.prohire.dao.PostulacionDAO;
import com.prohire.model.Postulacion;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PostulacionServlet", urlPatterns = {"/PostulacionServlet"})
public class PostulacionServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Postulacion p = new Postulacion();
        p.setId_profesional(Integer.parseInt(request.getParameter("id_profesional")));
        p.setId_vacante(Integer.parseInt(request.getParameter("id_vacante")));
        
        PostulacionDAO dao = new PostulacionDAO();
        
        if (dao.registrarPostulacion(p)) {
            // ¡La magia! Te devuelve al dashboard mostrando la alerta verde de éxito
            response.sendRedirect("dashboard_profesional.jsp?exito=1");
        } else {
            response.getWriter().print("<h1>❌ Error al postularse. Revisa la consola de NetBeans.</h1>");
        }
    }
}