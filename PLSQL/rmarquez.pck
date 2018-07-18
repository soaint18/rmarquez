CREATE OR REPLACE PACKAGE ExamRecu
AS
  rutaLocal varchar2(100) default 'C:\app\alumno\middleware\asinst_1\config\OHS\ohs1\htdocs\images\ejercicio\';
  rutaWeb   varchar2(100) default 'http://localhost/images/ejercicio/';
  
  PROCEDURE PantaInicio;
  PROCEDURE PantaModificar(tabla varchar2 DEFAULT NULL);
  PROCEDURE ModificarTabla(tabla varchar2 DEFAULT NULL,
                          priKey varchar2 DEFAULT NULL,
                          cbox1 varchar2 DEFAULT 'NADA', 
                          dato1 varchar2 DEFAULT NULL,
                          cbox2 varchar2 DEFAULT 'NADA',
                          dato2 varchar2 DEFAULT NULL,
                          cbox3 varchar2 DEFAULT 'NADA',
                          dato3 varchar2 DEFAULT NULL,
                          cbox4 varchar2 DEFAULT 'NADA',
                          dato4 varchar2 DEFAULT NULL,
                          cbox5 varchar2 DEFAULT 'NADA',
                          dato5 varchar2 DEFAULT NULL,
                          cbox6 varchar2 DEFAULT 'NADA',
                          dato6 varchar2 DEFAULT NULL,
                          cbox7 varchar2 DEFAULT 'NADA',
                          dato7 varchar2 DEFAULT NULL);
  PROCEDURE PantaRegistroCliente;
  PROCEDURE InsertarCliente(CodCliente number, 
                           NomCliente varchar2, 
                           FotoCliente varchar2, 
                           TipoCliente varchar2,
                           FechaClienteOwa owa_util.dateType, 
                           EmailCliente varchar2);
  PROCEDURE PantaListados(lista varchar2 DEFAULT NULL);
  PROCEDURE ListaCliente;
  PROCEDURE ListaTitulo;
  PROCEDURE ListaTodo;
  FUNCTION ValorIbex(titulo in varchar2) RETURN number;
  PROCEDURE PantaAcciones(operacion varchar2);
  PROCEDURE ComprarAcciones(cliente varchar2,
                           cantidad varchar2,
                           titulo varchar2);
  PROCEDURE VentaAcciones(cliente varchar2,
                         cantidad varchar2,
                         titulo varchar2);                            
  
  
  
  procedure lecturaMensajes;
  procedure opciones;
 
END ExamRecu;
/
CREATE OR REPLACE PACKAGE BODY ExamRecu
AS

/*----------------------------------------------------------------------------------*/
/*---------------------*/ PROCEDURE PantaInicio /*----------------------------------*/
/*----------------------------------------------------------------------------------*/
AS
    
BEGIN
 htp.p('<!DOCTYPE html>');
 htp.htmlOpen;
 htp.headOpen;
   htp.title('Inicio');
 htp.headClose;
 htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
 htp.centerOpen;
   htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
     htp.tableRowOpen(calign => 'center');
       htp.formOpen(curl => 'ExamRecu.PantaModificar');
         htp.p('<td width="140px" style="border-right: 0">');
           htp.formRadio(cname => 'tabla' , cvalue => 'clientes3');
           htp.p('Clientes');
         htp.p('</td>');
         htp.p('<td width="140px" style="border-right: 0; border-left: 0">');
           htp.formRadio(cname => 'tabla' , cvalue => 'audita3');
           htp.p('Audita');
         htp.p('</td>');
         htp.p('<td width="140px" style="border-right: 0; border-left: 0">');
           htp.formSubmit(cvalue => 'MODIFICAR VALORES');
         htp.p('</td>');
         htp.p('<td width="140px" style="border-right: 0; border-left: 0">');
           htp.formRadio(cname => 'tabla' , cvalue => 'clase_cli');
           htp.p('Tipo inversor');
         htp.p('</td>');
         htp.p('<td width="140px" style="border-left: 0">');
           htp.formRadio(cname => 'tabla' , cvalue => 'ibex');
           htp.p('Ibex');
         htp.p('</td>');
       htp.formClose;
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.PantaRegistroCliente');
           htp.formSubmit(cvalue => 'CLIENTE NUEVO');                
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.PantaListados');
           htp.formSubmit(cvalue => 'LISTADOS');                
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.PantaAcciones');
           htp.formHidden(cname => 'operacion', cvalue => 'comprar');
           htp.formSubmit(cvalue => 'ADQUIRIR ACCIONES');                
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.PantaAcciones');
           htp.formHidden(cname => 'operacion', cvalue => 'vender');
           htp.formSubmit(cvalue => 'VENDER ACCIONES');                
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.lecturaMensajes');
           htp.formSubmit(cvalue => 'LECTURA MENSAJES');  
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
     htp.tableRowOpen(calign => 'center');
       htp.p('<td colspan=5>');
         htp.formOpen(curl => 'ExamRecu.opciones');
           htp.formSubmit(cvalue => 'OPCIONES');
         htp.formClose;
       htp.p('</td>');
     htp.tableRowClose;
   htp.tableClose;
 htp.centerClose;
 htp.bodyClose;
 htp.htmlClose;
 
END PantaInicio;


/*----------------------------------------------------------------------------------*/
/*---------------------*/ PROCEDURE PantaModificar /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
(tabla varchar2 DEFAULT NULL)
AS
  priKey varchar2(20);
  cont   pls_integer := 0;
  
BEGIN
  IF tabla IS NULL THEN
    owa_util.redirect_url(curl => 'ExamRecu.PantaInicio');
  ELSE
  SELECT cols.column_name INTO priKey
    FROM all_constraints cons NATURAL JOIN all_cons_columns cols
    WHERE cons.constraint_type = 'P' AND table_name = UPPER(tabla);
  htp.p('<!DOCTYPE html>');
  htp.htmlOpen;
  htp.headOpen;
    htp.title('Modificar');
  htp.headClose;
  htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
  htp.centerOpen;
    htp.formOpen ( curl => 'ExamRecu.ModificarTabla', cenctype => 'multipart/form-data' );
    htp.header(nsize => 1, cheader => 'MODIFICACIONES', calign => 'center');
    htp.p(priKey);  
    owa_util.listprint('select '|| priKey || ',' || priKey || ',' || 'null from ' || tabla, 'priKey', 1);
    htp.header(nsize => 1, cheader => 'ACTUALIZACIONES DE DATOS', calign => 'center');
    htp.tableOpen(cattributes => 'border=15px bgcolor="lavender"');
    htp.formHidden(cname => 'tabla', cvalue => tabla);
    FOR fila IN (SELECT COLUMN_NAME, DATA_TYPE FROM USER_TAB_COLUMNS WHERE table_name = UPPER(tabla))
      LOOP
        IF fila.column_name NOT LIKE priKey THEN
          htp.tableRowOpen;
            htp.p('<td>');
              htp.formCheckbox(cname => 'cbox' || CONT , cvalue => fila.column_name );
              htp.p(fila.column_name);
            htp.p('</td>');
            htp.p('<td>');
          IF fila.column_name LIKE 'TIPO' THEN
            owa_util.listprint('select distinct(cual),cual,null from clase_cli', 'dato' || cont, 1);            
          ELSIF fila.data_type LIKE 'BLOB' THEN
            htp.formFile(cname => 'dato' || cont);
          ELSE
            htp.formText(cname => 'dato' || cont);
          END IF;
          htp.p('</td>');
          htp.tableRowClose;
        END IF;
        cont := cont+1;
      END LOOP;
    htp.tableClose;
    htp.formSubmit(cvalue => 'VALIDAR CAMBIOS', cattributes => 'margin="auto"');
    htp.formClose;
    htp.line;
    htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.formSubmit(cvalue => 'PAGINA INICIAL');
    htp.formClose;
    htp.centerClose;
  htp.bodyClose;
  htp.htmlClose;
  END IF;
END PantaModificar;



/*----------------------------------------------------------------------------------*/
/*----------------------*/ PROCEDURE ModificarTabla /*------------------------------*/
/*----------------------------------------------------------------------------------*/
(tabla varchar2 DEFAULT NULL, priKey varchar2 DEFAULT NULL,
 cbox1 varchar2 DEFAULT 'NADA', dato1  varchar2 DEFAULT NULL,
 cbox2 varchar2 DEFAULT 'NADA', dato2  varchar2 DEFAULT NULL,
 cbox3 varchar2 DEFAULT 'NADA', dato3  varchar2 DEFAULT NULL,
 cbox4 varchar2 DEFAULT 'NADA', dato4  varchar2 DEFAULT NULL,
 cbox5 varchar2 DEFAULT 'NADA', dato5  varchar2 DEFAULT NULL,
 cbox6 varchar2 DEFAULT 'NADA', dato6  varchar2 DEFAULT NULL,
 cbox7 varchar2 DEFAULT 'NADA', dato7  varchar2 DEFAULT NULL)
AS
  n             pls_integer;
  filas         pls_integer;
  orden         varchar2(200);
  primaryKey    varchar2(50);
  nombreFoto    varchar2(100);
  tipo          varchar2(50);
  type  miArray IS VARRAY(7) OF VARCHAR2(100); 
  arrayBox      miArray;
  arrayDatos    miArray;
  
BEGIN
  arrayBox := miArray(cbox1, cbox2, cbox3, cbox4, cbox5, cbox6, cbox7); 
  arrayDatos := miArray(dato1, dato2, dato3, dato4, dato5, dato6, dato7);
  SELECT cols.column_name INTO primaryKey
    FROM all_constraints cons NATURAL JOIN all_cons_columns cols
    WHERE cons.constraint_type = 'P' AND table_name = UPPER(tabla);
  FOR campo in 1 .. 7 LOOP
    IF arrayBox(campo) <> 'NADA' then
      SELECT DATA_TYPE INTO tipo
        FROM USER_TAB_COLUMNS
        WHERE table_name = UPPER(tabla)
        AND column_name = UPPER(arrayBox(campo));
      IF tipo LIKE 'VARCHAR2' OR tipo LIKE 'NUMBER' THEN
        orden := 'UPDATE ' || tabla || ' SET ' || arrayBox(campo) || 
                 ' = ' || '''' || arrayDatos(campo) || '''' || ' WHERE ' || primaryKey ||
                 ' LIKE ' || '''' || priKey || '''';
      ELSIF tipo LIKE 'DATE' THEN
        orden := 'UPDATE ' || tabla || ' SET ' || arrayBox(campo) || 
                 ' = ' || 'TO_DATE(' || '''' || arrayDatos(campo) ||
                 '''' || ') WHERE ' || primaryKey || ' LIKE ' || 
                 '''' || priKey || '''';
      ELSIF tipo LIKE 'BLOB' THEN
        nombreFoto := substr(arrayDatos(campo),instr(arrayDatos(campo),'/') + 1); 
        delete from parasubir where name = nombreFoto;
        update parasubir 
          set name = nombreFoto 
          where name = arrayDatos(campo); 
        orden := 'UPDATE ' || tabla ||
                 ' SET ' || arrayBox(campo) || ' = (' ||
                 ' select blob_content from parasubir where name = ' ||
                 '''' || nombreFoto || '''' || ') WHERE ' || primaryKey ||
                 ' LIKE ' || '''' || priKey || '''';
      END IF;
      n := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (n, orden, DBMS_SQL.native);
      filas := DBMS_SQL.execute(n);
      DBMS_SQL.close_cursor(n);
      COMMIT WORK;
    END IF;
  END LOOP;
  owa_util.redirect_url(curl => 'ExamRecu.PantaInicio');
  
  EXCEPTION
     WHEN OTHERS THEN
        htp.p('<!DOCTYPE html>');
        htp.htmlOpen;
        htp.headOpen;
        htp.title('ERROR');
        htp.headClose;
        htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
        htp.centerOpen;
        htp.formOpen(curl => 'ExamRecu.PantaInicio');
        htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
        htp.tableRowOpen(calign => 'center');
        htp.p('<td style="border: 0">');
        htp.p('ERROR AL MODIFICAR LOS DATOS.');
        htp.nl;
        htp.p('INTRODUZCA DATOS VALIDOS.');
        htp.p('</td>');
        htp.tableRowClose;
        htp.tableRowOpen(calign => 'center');
        htp.p('<td style="border: 0">');
        htp.formSubmit(cvalue => 'VOLVER');
        htp.p('</td>');
        htp.tableRowClose;
        htp.tableClose; 
        htp.formClose;
        htp.centerClose;
        htp.bodyClose;
        htp.htmlClose;
END ModificarTabla; 



/*----------------------------------------------------------------------------------*/
/*-------------------*/ PROCEDURE PantaRegistroCliente /*---------------------------*/
/*----------------------------------------------------------------------------------*/
AS

BEGIN
 htp.p('<!DOCTYPE html>');
 htp.htmlOpen;
 htp.headOpen;
   htp.title('Registro nuevo cliente');
 htp.headClose;
 htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
 htp.centerOpen;
   htp.formOpen(curl => 'ExamRecu.InsertarCliente', cenctype => 'multipart/form-data');
     htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.line;
           htp.p('Codigo de cliente:');
           htp.formText(cname => 'CodCliente');
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.p('Nombre:');
           htp.formText(cname => 'NomCliente');
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.formFile(cname => 'FotoCliente');
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');    
           htp.p('TIPO DE CLIENTE');
           htp.nl;
           owa_util.listprint('select distinct(cual),cual,null from clase_cli', 'TipoCliente', 1);
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.p('FECHA DE NACIMIENTO:');
           owa_util.choose_date(p_name => 'FechaClienteOwa',p_date => '1-1-1990');
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.p('E-MAIL:');
           htp.formText(cname => 'EmailCliente');
         htp.p('</td>');
       htp.tableRowClose;
       htp.tableRowOpen(calign => 'center');
         htp.p('<td style="border: 0">');
           htp.line;
           htp.formSubmit(cvalue => 'P R O C E S A R   N U E V O   C L I E N T E');
         htp.p('</td>');
       htp.tableRowClose;
     htp.tableClose; 
   htp.formClose;
 htp.centerClose;
 htp.bodyClose;
 htp.htmlClose;
END PantaRegistroCliente;



/*----------------------------------------------------------------------------------*/
/*------------------*/ PROCEDURE InsertarCliente/*----------------------------------*/
/*----------------------------------------------------------------------------------*/
(CodCliente number, NomCliente varchar2, FotoCliente varchar2, TipoCliente varchar2,
 FechaClienteOwa owa_util.dateType, EmailCliente varchar2)
AS
  nombreFoto varchar2(100);
  fechaClienteDate date;
  
BEGIN
  fechaClienteDate := owa_util.todate(FechaClienteOwa);
  INSERT INTO CLIENTES3 
    VALUES (CodCliente, NomCliente, empty_blob(), fechaClienteDate, TipoCliente, EmailCliente);
  nombreFoto := substr(FotoCliente,instr(FotoCliente,'/') + 1); 
  delete from parasubir where name = nombreFoto; 
  update parasubir 
    set name = nombreFoto 
    where name = FotoCliente; 
  update CLIENTES3
    set foto = (select blob_content from parasubir where name = nombreFoto) 
    where nombre = NomCliente;
  commit work;
  owa_util.redirect_url(curl => 'ExamRecu.PantaInicio');
  
  EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        htp.p('<!DOCTYPE html>');
        htp.htmlOpen;
        htp.headOpen;
        htp.title('ERROR');
        htp.headClose;
        htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
        htp.centerOpen;
        htp.formOpen(curl => 'ExamRecu.PantaRegistroCliente');
        htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
        htp.tableRowOpen(calign => 'center');
        htp.p('<td style="border: 0">');
        htp.p('YA EXISTE UN CLIENTE CON ESE COD.');
        htp.nl;
        htp.p('SELECCIONA UN COD DISTINTO.');
        htp.p('</td>');
        htp.tableRowClose;
        htp.tableRowOpen(calign => 'center');
        htp.p('<td style="border: 0">');
        htp.formSubmit(cvalue => 'VOLVER');
        htp.p('</td>');
        htp.tableRowClose;
        htp.tableClose; 
        htp.formClose;
        htp.centerClose;
        htp.bodyClose;
        htp.htmlClose;
END InsertarCliente;



/*----------------------------------------------------------------------------------*/
/*----------------------*/ PROCEDURE PantaListados /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
(lista varchar2 DEFAULT NULL)
AS

BEGIN
  IF lista = 'CLIENTE' THEN
    owa_util.redirect_url(curl => 'ExamRecu.ListaCliente');
  ELSIF lista = 'TITULO' THEN
    owa_util.redirect_url(curl => 'ExamRecu.ListaTitulo');
  ELSIF lista = 'TODO' THEN
    owa_util.redirect_url(curl => 'ExamRecu.ListaTodo');
  ELSE
    htp.p('<!DOCTYPE html>');
    htp.htmlOpen;
    htp.headOpen;
      htp.title('Listados');
    htp.headClose;
    htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
    htp.centerOpen;
      htp.formOpen(curl => 'ExamRecu.PantaListados');
        htp.tableOpen(cattributes => 'border=15px bgcolor="lavender"');
          htp.tableRowOpen(calign => 'center');
            htp.p('<td>');
              htp.formRadio(cname => 'lista' , cvalue => 'CLIENTE');
              htp.p('TOTAL ACCIONES POR CLIENTE');
            htp.p('</td>');
            htp.p('<td>');
              htp.formRadio(cname => 'lista' , cvalue => 'TITULO');
              htp.p('TOTAL ACCIONES POR TITULO');
            htp.p('</td>');
            htp.p('<td>');
              htp.formRadio(cname => 'lista' , cvalue => 'TODO');
              htp.p('CARTERA EN TIEMPO REAL');
            htp.p('</td>');
          htp.tableRowClose;  
        htp.tableClose; 
        htp.formSubmit(cvalue => 'C O N S U L T A R', cattributes => 'margin="auto"');
      htp.formClose;
      htp.line;
      htp.line;
      htp.nl;
      htp.formOpen(curl => 'ExamRecu.PantaInicio');
        htp.formSubmit(cvalue => 'PAGINA INICIAL');
      htp.formClose;
    htp.centerClose;
    htp.bodyClose;
    htp.htmlClose;
  END IF;
        
END PantaListados;



/*----------------------------------------------------------------------------------*/
/*---------------------*/ PROCEDURE ListaCliente /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
AS
fotoCli BLOB;

BEGIN
  htp.htmlOpen;
  htp.headOpen;
    htp.title('ACCIONES POR CLIENTE');
  htp.headClose;
  htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
    htp.centerOpen;
    htp.header(1,'TOTAL ACCIONES POSEIDAS POR CLIENTE');
    htp.tableOpen(cattributes => 'border=15px bgcolor="lavender"');
      FOR cliente in (Select nombre, sum(numero) total
                       from cartera3 ca , clientes3 cl 
                       where cl.clientes_cod = ca.clientes_cod
                       group by cl.nombre)
      LOOP
        htp.tableRowOpen; 
          htp.p('<td>');
          select foto into fotoCli 
            from clientes3
            where nombre = cliente.nombre;
          utl_binfile.save_blob_to_file(b => fotoCli, filename => ExamRecu.rutalocal || cliente.nombre || '.jpg'); 
          htp.img(curl => ExamRecu.rutaweb || cliente.nombre || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
          htp.p('</td>');
          htp.p('<td>');
            htp.p(htf.bold(cliente.nombre));
          htp.p('</td>');
          htp.p('<td>');
            htp.p('NUMERO DE ACCIONES:  ');
            htp.p(cliente.total);
          htp.p('</td>');
        htp.tableRowClose;
      END LOOP;
    htp.tableClose;
    htp.line;
    htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.formSubmit(cvalue => 'PAGINA INICIAL');
    htp.formClose;
  htp.centerClose;
  htp.bodyClose;
  htp.htmlClose;
  
END ListaCliente;




/*----------------------------------------------------------------------------------*/
/*---------------------*/ PROCEDURE ListaTitulo /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
AS
logoTitulo BLOB;

BEGIN
  htp.htmlOpen;
  htp.headOpen;
    htp.title('ACCIONES POR TITULO');
  htp.headClose;
  htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
    htp.centerOpen;
    htp.header(1,'TOTAL ACCIONES POR TITULO');
    htp.tableOpen(cattributes => 'border=15px bgcolor="lavender"');
      FOR titulo in (Select nombre, sum(numero) total
                      from cartera3 ca , ibex ib 
                      where ib.valor_cod = ca.valor_cod
                      group by ib.nombre)
      LOOP
        htp.tableRowOpen; 
          htp.p('<td>');
          select logo into logoTitulo
            from ibex
            where nombre = titulo.nombre;
          utl_binfile.save_blob_to_file(b => logoTitulo, filename => ExamRecu.rutalocal || titulo.nombre || '.jpg'); 
          htp.img(curl => ExamRecu.rutaweb || titulo.nombre || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
          htp.p('</td>');
          htp.p('<td>');
            htp.p(htf.bold(titulo.nombre));
          htp.p('</td>');
          htp.p('<td>');
            htp.p('NUMERO DE ACCIONES:  ');
            htp.p(titulo.total);
          htp.p('</td>');
        htp.tableRowClose;
      END LOOP;
    htp.tableClose;
    htp.line;
    htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.formSubmit(cvalue => 'PAGINA INICIAL');
    htp.formClose;
  htp.centerClose;
  htp.bodyClose;
  htp.htmlClose;
  
END ListaTitulo;




/*----------------------------------------------------------------------------------*/
/*---------------------*/ PROCEDURE ListaTodo /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
AS
fotoCli    BLOB;
logoTitulo BLOB;

BEGIN
  htp.htmlOpen;
  htp.headOpen;
    htp.title('ACCIONES POR CLIENTE');
  htp.headClose;
  htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
    htp.centerOpen;
    htp.header(1,'VALORACION DE LA CARTERA EN TIEMPO REAL');
    htp.tableOpen(cattributes => 'border=15px bgcolor="lavender"');
      FOR todo in (Select cl.nombre cliente, ib.nombre titulo , ca.numero accion
                    from clientes3 cl, cartera3 ca , ibex ib 
                    where ib.valor_cod = ca.valor_cod
                    and cl.clientes_cod = ca.clientes_cod)
      LOOP
        htp.tableRowOpen;
          htp.p('<td>');
          select foto into fotoCli 
            from clientes3
            where nombre = todo.cliente;
          utl_binfile.save_blob_to_file(b => fotoCli, filename => ExamRecu.rutalocal || todo.cliente || '.jpg'); 
          htp.img(curl => ExamRecu.rutaweb || todo.cliente || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
          htp.p('</td>');
          htp.p('<td>');
            htp.p(htf.bold(todo.cliente));
          htp.p('</td>');
          htp.p('<td>');
          select logo into logoTitulo
            from ibex
            where nombre = todo.titulo;
          utl_binfile.save_blob_to_file(b => logoTitulo, filename => ExamRecu.rutalocal || todo.titulo || '.jpg'); 
          htp.img(curl => ExamRecu.rutaweb || todo.titulo || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
          htp.p('</td>');
          htp.p('<td>');
            htp.p(htf.bold(todo.titulo));
          htp.p('</td>');
          htp.p('<td>');
            htp.p('Valoracion actual:  ');
            htp.p(todo.accion * ValorIbex(todo.titulo));
          htp.p('</td>');
        htp.tableRowClose;
      END LOOP;
    htp.tableClose;
    htp.line;
    htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.formSubmit(cvalue => 'PAGINA INICIAL');
    htp.formClose;
  htp.centerClose;
  htp.bodyClose;
  htp.htmlClose;
  
END ListaTodo;



/*----------------------------------------------------------------------------------*/
/*-------------------------*/ FUNCTION ValorIbex /*---------------------------------*/
/*----------------------------------------------------------------------------------*/
(titulo in varchar2) RETURN NUMBER

AS
  web    varchar2(200) := 'http://www.eleconomista.es/interstitial/volver/robsep15/indice/IBEX-35';
  tabla  utl_http.html_pieces;
  inicio pls_integer;
  fin    pls_integer;
  texto  varchar2(2000);

BEGIN
  tabla := utl_http.request_pieces(web);
  
  FOR i IN 1..tabla.count 
  LOOP
    inicio := instr(tabla(i),upper(titulo),1,2);
    IF inicio <> 0 then
      fin := instr(tabla(i),'</span>',inicio+1);
      IF fin = 0 THEN
        fin := instr(tabla(i+1),'</span>',1);
        texto := substr(tabla(i),inicio) || substr(tabla(i+1),1,fin-1);
      ELSE
        texto := substr(tabla(i),inicio,fin-inicio);
      END IF;
    END IF;
  END LOOP;
  inicio := instr(texto,'lightstreamer');
  texto := substr(texto,inicio+15);
  texto := replace(texto,'.',',');
  RETURN to_number(texto);
  
  EXCEPTION
    WHEN OTHERS THEN
      htp.p('<!DOCTYPE html>');
      htp.htmlOpen;
      htp.headOpen;
      htp.title('ERROR');
      htp.headClose;
      htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
      htp.centerOpen;
      htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.p('NO SE HA PODIDO CONECTAR CON EL SERVICIO WEB DE BOLSA.');
      htp.nl;
      htp.p('COMPRUEBE LA CONEXION.');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.formSubmit(cvalue => 'VOLVER');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableClose; 
      htp.formClose;
      htp.centerClose;
      htp.bodyClose;
      htp.htmlClose;
  
END ValorIbex;



/*----------------------------------------------------------------------------------*/
/*----------------------*/ PROCEDURE PantaAcciones /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
(operacion varchar2)
AS

BEGIN
htp.p('<!DOCTYPE html>');
      htp.htmlOpen;
      htp.headOpen;
        htp.title('ACCIONES');
      htp.headClose;
      htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
        htp.p('<div style="width: 850px; margin: auto">');
        IF operacion = 'comprar' THEN
                htp.formOpen(curl => 'ExamRecu.ComprarAcciones');
        ELSIF operacion = 'vender' THEN
                htp.formOpen(curl => 'ExamRecu.VentaAcciones');
        END IF;
        htp.p('<div style="float: left; width: 210px;">');
          htp.tableOpen(cattributes => 'width=200px border=15px bgcolor="lavender"');
          FOR cliente in (Select * from clientes3)
          LOOP
            htp.tableRowOpen; 
              htp.p('<td>');
                htp.formRadio(cname => 'cliente' , cvalue => cliente.clientes_cod);
              htp.p('</td>');
              htp.p('<td>');
                utl_binfile.save_blob_to_file(b => cliente.foto, filename => ExamRecu.rutalocal || cliente.nombre || '.jpg'); 
                htp.img(curl => ExamRecu.rutaweb || cliente.nombre || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
              htp.p('</td>');
              htp.p('<td>');
                htp.p(htf.bold(cliente.nombre));
              htp.p('</td>');
            htp.tableRowClose;
          END LOOP;
          htp.tableClose;
          htp.p('</div>'); 
          htp.p('<div style="float: left; width: 420px;">');
            htp.centerOpen;
              htp.p('Numero de acciones:  ');
              htp.formText(cname => 'cantidad',csize => 4);
              htp.nl;
              htp.nl;
              IF operacion = 'comprar' THEN
                htp.formSubmit(cvalue => 'COMPRAR ACCIONES');
              ELSIF operacion = 'vender' THEN
                htp.formSubmit(cvalue => 'VENDER ACCIONES');
              END IF;
            htp.line;
              htp.anchor(ctext => 'PAGINA INICIAL',curl => 'ExamRecu.PantaInicio');
            htp.line;
            htp.centerClose;
          htp.p('</div>');           
          htp.p('<div style="float: right; width: 210px;">');
          htp.tableOpen(cattributes => 'width=200px border=15px bgcolor="lavender"');
          FOR titulo in (Select * from ibex)
          LOOP
            htp.tableRowOpen; 
              htp.p('<td>');
                htp.formRadio(cname => 'titulo' , cvalue => titulo.valor_cod);
              htp.p('</td>');
              htp.p('<td>');
                utl_binfile.save_blob_to_file(b => titulo.logo, filename => ExamRecu.rutalocal || titulo.nombre || '.jpg'); 
                htp.img(curl => ExamRecu.rutaweb || titulo.nombre || '.jpg', cattributes => 'WIDTH="50" HEIGHT="50"');
              htp.p('</td>');
              htp.p('<td>');
                htp.p(htf.bold(titulo.nombre));
              htp.p('</td>');
            htp.tableRowClose;
          END LOOP;
          htp.tableClose;          
          htp.p('</div>');
        htp.formClose;
        htp.p('</div>'); 
      htp.bodyClose;
      htp.htmlClose;
      
      
END PantaAcciones;     
      
      

/*----------------------------------------------------------------------------------*/
/*----------------------*/ PROCEDURE ComprarAcciones /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
(cliente varchar2, cantidad varchar2, titulo varchar2)
AS
  accionesAntes    number;
BEGIN
  select numero into accionesAntes
   from cartera3 
   where clientes_cod = cliente
   and valor_cod = titulo;
  update cartera3 set (numero) = accionesAntes + cantidad;
  htp.p('<!DOCTYPE html>');
  htp.htmlOpen;
  htp.headOpen;
  htp.title('ERROR');
  htp.headClose;
  htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
  htp.centerOpen;
  htp.formOpen(curl => 'ExamRecu.PantaInicio');
  htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
  htp.tableRowOpen(calign => 'center');
  htp.p('<td style="border: 0">');
  htp.p('COMPRA REALIZADA.');
  htp.p('</td>');
  htp.tableRowClose;
  htp.tableRowOpen(calign => 'center');
  htp.p('<td style="border: 0">');
  htp.formSubmit(cvalue => 'VOLVER');
  htp.p('</td>');
  htp.tableRowClose;
  htp.tableClose; 
  htp.formClose;
  htp.centerClose;
  htp.bodyClose;
  htp.htmlClose;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    insert into cartera3 values (cliente, titulo, cantidad);
  WHEN OTHERS THEN
      htp.p('<!DOCTYPE html>');
      htp.htmlOpen;
      htp.headOpen;
      htp.title('ERROR');
      htp.headClose;
      htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
      htp.centerOpen;
      htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.p('ERROR EN LA COMPRAR.');
      htp.nl;
      htp.p('INTRODUZCA UN NUEMRO CORRECTO DE ACCIONES.');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.formSubmit(cvalue => 'VOLVER');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableClose; 
      htp.formClose;
      htp.centerClose;
      htp.bodyClose;
      htp.htmlClose;
      
END ComprarAcciones;




/*----------------------------------------------------------------------------------*/
/*----------------------*/ PROCEDURE VentaAcciones /*-------------------------------*/
/*----------------------------------------------------------------------------------*/
(cliente varchar2, cantidad varchar2, titulo varchar2)
AS
  accionesAntes    number;
  accionesDespues  number;
BEGIN
  select numero into accionesAntes
   from cartera3 
   where clientes_cod = cliente
   and valor_cod = titulo;
  accionesDespues := accionesAntes - cantidad;
  IF accionesDespues > 0 THEN
    update cartera3 set (numero) = accionesDespues;
    htp.p('<!DOCTYPE html>');
    htp.htmlOpen;
    htp.headOpen;
    htp.title('ERROR');
    htp.headClose;
    htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
    htp.centerOpen;
    htp.formOpen(curl => 'ExamRecu.PantaInicio');
    htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
    htp.tableRowOpen(calign => 'center');
    htp.p('<td style="border: 0">');
    htp.p('VENTA REALIZADA.');
    htp.p('</td>');
    htp.tableRowClose;
    htp.tableRowOpen(calign => 'center');
    htp.p('<td style="border: 0">');
    htp.formSubmit(cvalue => 'VOLVER');
    htp.p('</td>');
    htp.tableRowClose;
    htp.tableClose; 
    htp.formClose;
    htp.centerClose;
    htp.bodyClose;
    htp.htmlClose;
  ELSE
    RAISE NO_DATA_FOUND;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    htp.p('<!DOCTYPE html>');
      htp.htmlOpen;
      htp.headOpen;
      htp.title('ERROR');
      htp.headClose;
      htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
      htp.centerOpen;
      htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.p('IMPOSIBLE EFECTUAR LA VENTA.');
      htp.nl;
      htp.p('ESE CLIENTE NO TIENE SUFICIENTES ACCIONES.');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.formSubmit(cvalue => 'VOLVER');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableClose; 
      htp.formClose;
      htp.centerClose;
      htp.bodyClose;
      htp.htmlClose;  
  WHEN OTHERS THEN
      htp.p('<!DOCTYPE html>');
      htp.htmlOpen;
      htp.headOpen;
      htp.title('ERROR');
      htp.headClose;
      htp.bodyOpen(cattributes => 'BGCOLOR = "slateblue"');
      htp.centerOpen;
      htp.formOpen(curl => 'ExamRecu.PantaInicio');
      htp.tableOpen(cattributes => 'width=700px border=15px bgcolor="lavender"');
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.p('ERROR EN LA VENTA.');
      htp.nl;
      htp.p('INTRODUZCA UN NUEMRO CORRECTO DE ACCIONES.');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableRowOpen(calign => 'center');
      htp.p('<td style="border: 0">');
      htp.formSubmit(cvalue => 'VOLVER');
      htp.p('</td>');
      htp.tableRowClose;
      htp.tableClose; 
      htp.formClose;
      htp.centerClose;
      htp.bodyClose;
      htp.htmlClose;        
      
END VentaAcciones;



---------pantalla lectura de mensajes---------------
procedure lecturaMensajes
AS
BEGIN
htp.htmlOpen;
 htp.headOpen;
 htp.title('lectura Mensajes');
 htp.headClose;
 htp.bodyOpen(cattributes => 'BGCOLOR = "pink"');
 htp.bodyClose;
 htp.htmlClose;
END lecturaMensajes;
---------pantalla opciones--------------------------
procedure opciones
AS
BEGIN
htp.htmlOpen;
 htp.headOpen;
 htp.title('opciones');
 htp.headClose;
 htp.bodyOpen(cattributes => 'BGCOLOR = "pink"');
 htp.bodyClose;
 htp.htmlClose;
END opciones;

END ExamRecu;------FIN
/
