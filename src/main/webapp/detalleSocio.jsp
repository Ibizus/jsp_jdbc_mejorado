<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalle Socio</title>
</head>
<body>
<h1>Detalle de Socio</h1>
<%
    int socioID = Integer.parseInt(request.getParameter("socioID"));
    System.out.println(socioID);
    Connection conexion = null;
    PreparedStatement ps = null;

    //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
    //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
    Class.forName("com.mysql.cj.jdbc.Driver");
    conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");

    //UTILIZAMOS PREPARE STATEMENT PARA QUERIES PARAMETRIZADAS.
    String sql = "SELECT * FROM socio WHERE socioID = ?"; //socioID
    ps = conexion.prepareStatement(sql);
    ps.setInt(1, socioID);

    ResultSet resultSocio = ps.executeQuery();
    //ps.executeUpdate();

    while (resultSocio.next()) {
        out.println("Borrado el socio: " + resultSocio.getString("socioID") + " " + resultSocio.getString ("nombre") + "<br>");
    }

    resultSocio.close();
    ps.close();
    conexion.close();
%>
</body>
</html>