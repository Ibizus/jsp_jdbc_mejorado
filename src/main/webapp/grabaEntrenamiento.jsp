<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    String tipo = null;
    String ubicacion = null;
    java.util.Date fechaD = null;

    boolean flagValidaTipoNull = false;
    boolean flagValidaTipoBlank = false;
    boolean flagValidaTipoCorrect = false;
    boolean flagValidaUbicacionNull = false;
    boolean flagValidaUbicacionBlank = false;
    boolean flagValidaFecha = false;
    try {

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("tipo"));
        flagValidaTipoNull = true;
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("tipo").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaTipoBlank = true;
        tipo = request.getParameter("tipo");

        // VALIDA TIPO CORRECTO:
        if (!request.getParameter("tipo").equalsIgnoreCase("Técnico") || !request.getParameter("tipo").equalsIgnoreCase("Físico")) throw new RuntimeException("El tipo no coincide.");
        flagValidaTipoCorrect = true;

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("ubicacion"));
        flagValidaUbicacionNull = true;
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaUbicacionBlank = true;
        ubicacion = request.getParameter("ubicacion");


        // VALIDA FECHA:
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        fechaD = formato.parse(request.getParameter("fecha"));
        flagValidaFecha = true;


    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaTipoNull || !flagValidaTipoBlank || !flagValidaTipoCorrect) {
            session.setAttribute("error", "Error en tipo");
        } else if (!flagValidaUbicacionBlank || !flagValidaUbicacionNull) {
            session.setAttribute("error", "Error en ubicación");
        } else if (!flagValidaFecha){
            session.setAttribute("error", "Error en fecha");
        }

        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rsGenKeys = null;
        //ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:30306/baloncesto", "root", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            //String sql = "INSERT INTO entrenamiento VALUES ( " +
            //        "?, " + //tipo
            //        "?, " + //ubicacion
            //        "?)"; //fecha


            //1 alternativas comentadas:
            //Ver también, AbstractDAOImpl.executeInsert ...
            //Columna fabricante.codigo es clave primaria auto_increment, por ese motivo se omite de la sentencia SQL INSERT siguiente.
            ps = conn.prepareStatement("INSERT INTO entrenamiento (tipo, ubicacion, fecha) VALUES (?, ? , ?)", Statement.RETURN_GENERATED_KEYS);

            //ps = conn.prepareStatement(sql);

            int idx = 1;
            ps.setString(idx++, tipo);
            ps.setString(idx++, ubicacion);
            ps.setDate(idx++, new java.sql.Date(fechaD.getTime()));

            int filasAfectadas = ps.executeUpdate();
            System.out.println("ENTRENAMIENTO GRABADO:  " + filasAfectadas);

            rsGenKeys = ps.getGeneratedKeys();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        // en vez de mostrar mensaje voy a redirigir a detalle del socio mandándole el numero de socio
        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);

        // otra forma:
        session.setAttribute("entrenamientoADestacar", rsGenKeys.getInt(1));
        response.sendRedirect("listadoEntrenamiento.jsp"); // El ID del socio lo he metido a la session

    } else {
        //out.println("Error de validación!");

        // En vez de mostrar mensaje reenvio a formulario para mostrar el error:
        response.sendRedirect("formularioEntrenamiento.jsp");
    }
%>

</body>
</html>