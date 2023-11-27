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

    ResultSet listado = s.executeQuery ("SELECT * FROM socio");
%>
<table>
    <tr><th>ID Entrenamiento</th><th>Tipo</th><th>Ubicación</th><th>Fecha</th></tr>
    <%
        Integer socioIDADestacar = (Integer)session.getAttribute("socioADestacar");
        String claseDestacar = "";
        while (listado.next()) {

            claseDestacar = (socioIDADestacar != null && socioIDADestacar == listado.getInt("socioID")) ? "destacar" : "";

    %>
    <tr class="<%= claseDestacar%>">
        <td>
            <%= listado.getString("socioID")%>
        </td>
        <td>
            <%= listado.getString("nombre")%>
        </td>
        <td>
            <%= listado.getString("estatura")%>
        </td>
        <td>
            <%= listado.getString("edad")%>
        </td>
        <td>
            <%= listado.getString("localidad")%>
        </td>
        <td>
            <form method="get" action="borraSocio.jsp">
                <input type="hidden" name="codigo" value="<%=listado.getString("socioID") %>"/>
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