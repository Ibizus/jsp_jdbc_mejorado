<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto","root", "user");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery ("SELECT * FROM entrenamiento");
%>
<table>
    <tr><th>ID Entrenamiento</th><th>Tipo</th><th>Ubicación</th><th>Fecha</th>
    <th><a href="menuEntrenamiento.jsp">Menú</a></th>
    </tr>
    <%
        Integer entrenamientoID = (Integer)session.getAttribute("entrenamientoADestacar");
        String claseDestacar = "";
        while (listado.next()) {

            claseDestacar = (entrenamientoID != null && entrenamientoID == listado.getInt("entrenamientoID")) ? "destacar" : "";

    %>
    <tr class="<%= claseDestacar%>">
        <td>
            <%= listado.getString("entrenamientoID")%>
        </td>
        <td>
            <%= listado.getString("tipo")%>
        </td>
        <td>
            <%= listado.getString("ubicacion")%>
        </td>
        <td>
            <%= listado.getString("fecha")%>
        </td>
        <td>
            <form method="get" action="borraEntrenamiento.jsp">
                <input type="hidden" name="identificador" value="<%=listado.getString("entrenamientoID") %>"/>
                <input type="submit" value="borrar">
            </form>
        </td>
    </tr>
    <%
        } // while
        conexion.close();
    %>
</table>
</body>
</html>