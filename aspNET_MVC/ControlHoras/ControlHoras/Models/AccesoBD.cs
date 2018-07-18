using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;

namespace ControlHoras.Models
{
    public class AccesoBD
    {
        #region "-------- Propiedades de clase-----"

        private string __cadenaConexion = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["HorasBD"].ConnectionString;
        private SqlConnection __miconexionBD;
        private SqlCommand __micomandoSQL;

        private List<Proyecto> __proyectos = new List<Proyecto>();
        private List<Tarea> __tareas = new List<Tarea>();

        #endregion

        #region "-------- metodos de clase ------"

        public void AbrirConexion()
        {
            this.__miconexionBD = new SqlConnection(this.__cadenaConexion);
            try
            {
                this.__miconexionBD.Open();
            }
            catch (SqlException ex)
            {

            }
        }

        public List<Proyecto> DevolverProyectos(string cadena = null, string criterio = null)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand();
            this.__micomandoSQL.Connection = this.__miconexionBD;
            if (cadena == null || criterio == null)
            {
                this.__micomandoSQL.CommandText = "SELECT * FROM Proyectos";
            }
            else
            {
                if (criterio == "FechaInicio" && cadena != null && cadena != "")
                {
                    DateTime date = DateTime.ParseExact(cadena, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    cadena = date.ToString("yyyy-MM-dd");
                }
                this.__micomandoSQL.CommandText = "SELECT * FROM Proyectos where " + criterio + " LIKE '" + cadena + "%'";
            }
       
            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    Proyecto newProyecto = new Proyecto()
                    {
                        Nombre = resultadoSelect["Nombre"].ToString(),
                        Tipo = resultadoSelect["Tipo"].ToString(),
                        Cliente = resultadoSelect["Cliente"].ToString(),
                        Responsable = resultadoSelect["Responsable"].ToString(),
                        FechaInicio = resultadoSelect["FechaInicio"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaInicio"]).ToString("dd/MM/yyyy") : null,
                        FechaCierrePrevista = resultadoSelect["FechaCierrePrevista"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaCierrePrevista"]).ToString("dd/MM/yyyy") : null,
                        HorasPrevistas = resultadoSelect["HorasPrevistas"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasPrevistas"]) : 0,
                        FechaCierreReal = resultadoSelect["FechaCierreReal"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaCierreReal"]).ToString("dd/MM/yyyy") : null,
                        HorasReales = resultadoSelect["HorasReales"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasReales"]) : 0,
                        Coste = resultadoSelect["Coste"].ToString().Length > 0 ? Convert.ToInt32(resultadoSelect["Coste"]) : 0,
                        Observaciones = resultadoSelect["Observaciones"].ToString()
                    };

                    __proyectos.Add(newProyecto);
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __proyectos;
        }

        public List<Proyecto> DevolverProyectosUsuario(string Nombre)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand();
            this.__micomandoSQL.Connection = this.__miconexionBD;
            this.__micomandoSQL.CommandText = "SELECT DISTINCT(Proyecto), SUM(HorasReales) Horas FROM Tareas WHERE Tecnico = '" + Nombre +"' GROUP BY Proyecto";

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    Proyecto newProyecto = new Proyecto()
                    {
                        Nombre = resultadoSelect["Proyecto"].ToString(),
                        HorasReales = resultadoSelect["Horas"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["Horas"]) : 0,
                    };

                    __proyectos.Add(newProyecto);
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __proyectos;
        }

        public List<Tarea> DevolverTareas(string proyecto)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand
            {
                Connection = this.__miconexionBD,
                CommandText = "SELECT * FROM Tareas WHERE Proyecto = '" + proyecto +"'"
            };

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    Tarea newTarea = new Tarea()
                    {
                        Nombre = resultadoSelect["Nombre"].ToString(),
                        Proyecto = resultadoSelect["Proyecto"].ToString(),
                        FechaInicio = resultadoSelect["FechaInicio"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaInicio"]).ToString("dd/MM/yyyy") : null,
                        FechaFin = resultadoSelect["FechaFin"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaFin"]).ToString("dd/MM/yyyy") : null,
                        HorasEstimadas = resultadoSelect["HorasEstimadas"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasEstimadas"]) : 0,
                        HorasReales = resultadoSelect["HorasReales"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasReales"]) : 0,
                        Tecnico = resultadoSelect["Tecnico"].ToString(),
                        Coste = resultadoSelect["Coste"].ToString().Length > 0 ? Convert.ToInt32(resultadoSelect["Coste"]) : 0
                    };

                    __tareas.Add(newTarea);
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __tareas;
        }

        public List<Tarea> DevolverTareasUsuario(string Nombre, string proyecto)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand();
            this.__micomandoSQL.Connection = this.__miconexionBD;
            this.__micomandoSQL.CommandText = "SELECT * FROM Tareas WHERE Tecnico = '" + Nombre + "' AND Proyecto = '"+ proyecto +"'";

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    Tarea newTarea = new Tarea()
                    {
                        Nombre = resultadoSelect["Nombre"].ToString(),
                        Proyecto = resultadoSelect["Proyecto"].ToString(),
                        FechaInicio = resultadoSelect["FechaInicio"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaInicio"]).ToString("dd/MM/yyyy") : null,
                        FechaFin = resultadoSelect["FechaFin"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaFin"]).ToString("dd/MM/yyyy") : null,
                        HorasEstimadas = resultadoSelect["HorasEstimadas"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasEstimadas"]) : 0,
                        HorasReales = resultadoSelect["HorasReales"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasReales"]) : 0,
                        Tecnico = resultadoSelect["Tecnico"].ToString(),
                        Coste = resultadoSelect["Coste"].ToString().Length > 0 ? Convert.ToInt32(resultadoSelect["Coste"]) : 0
                    };

                    __tareas.Add(newTarea);
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __tareas;
        }

        public List<Tarea> DevolverTareasLista(string proyecto, string criterio, string cadena = "")
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand();
            this.__micomandoSQL.Connection = this.__miconexionBD;
            if(criterio == "Todo")
            {
                this.__micomandoSQL.CommandText = "SELECT * FROM Tareas WHERE Proyecto = '"+ proyecto +"'";
            }
            else
            {
                if ((criterio == "FechaInicio" && cadena != null && cadena != "") ||(criterio == "FechaFin" && cadena != null && cadena != ""))
                {
                    try
                    {
                        DateTime date = DateTime.ParseExact(cadena, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        cadena = date.ToString("yyyy-MM-dd");
                    }
                    catch { cadena = "0000-00-00"; }
                }
                this.__micomandoSQL.CommandText = "SELECT * FROM Tareas where " + criterio + " LIKE '" + cadena + "%' AND Proyecto = '" + proyecto + "'";
            }

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    Tarea newTarea = new Tarea()
                    {
                        Nombre = resultadoSelect["Nombre"].ToString(),
                        Proyecto = resultadoSelect["Proyecto"].ToString(),
                        FechaInicio = resultadoSelect["FechaInicio"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaInicio"]).ToString("dd/MM/yyyy") : null,
                        FechaFin = resultadoSelect["FechaFin"].ToString().Length > 0 ? Convert.ToDateTime(resultadoSelect["FechaFin"]).ToString("dd/MM/yyyy") : null,
                        HorasEstimadas = resultadoSelect["HorasEstimadas"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasEstimadas"]) : 0,
                        HorasReales = resultadoSelect["HorasReales"].ToString().Length > 0 ? Convert.ToInt16(resultadoSelect["HorasReales"]) : 0,
                        Tecnico = resultadoSelect["Tecnico"].ToString(),
                        Coste = resultadoSelect["Coste"].ToString().Length > 0 ? Convert.ToInt32(resultadoSelect["Coste"]) : 0
                    };

                    __tareas.Add(newTarea);
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __tareas;
        }

        public Horas DevolverHoras(string nombre, string proyecto, string tarea, int mes)
        {
            Horas __horas = new Horas();
            Dias __dia = new Dias();
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand
            {
                Connection = this.__miconexionBD,
                CommandText = "SELECT * FROM Horas WHERE Empleado = '" + nombre + 
                                                   "' AND Proyecto = '" + proyecto +
                                                   "' AND Tarea = '" + tarea +
                                                   "'" + " AND Mes = " + mes
            };

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();

            try
            {
                if (resultadoSelect.HasRows)
                {
                    while (resultadoSelect.Read())
                    {
                        Horas newHoras = new Horas()
                        {
                            Empleado = resultadoSelect["Empleado"].ToString(),
                            Proyecto = resultadoSelect["Proyecto"].ToString(),
                            Tarea = resultadoSelect["Tarea"].ToString(),
                            Mes = resultadoSelect["Mes"].ToString(),
                            Total = resultadoSelect["Total"].ToString()
                        };

                        for (int i = 1; i <= 31; i++)
                        {
                            Dias newDia = new Dias()
                            {
                                Dia = resultadoSelect["D" + Convert.ToString(i)].ToString(),
                                Horas = resultadoSelect["H" + Convert.ToString(i)].ToString(),
                                Observacion = resultadoSelect["O"+ Convert.ToString(i)].ToString(),
                                Comentario = resultadoSelect["C" + Convert.ToString(i)].ToString(),
                            };
                            newHoras.Dias.Add(newDia);
                        }

                        __horas = newHoras;
                    }
                    resultadoSelect.Close();
                    this.CerrarConexion();
                }
                else
                {
                    resultadoSelect.Close();
                    this.__micomandoSQL = new SqlCommand("INSERT INTO Horas (Empleado,Proyecto,Tarea,Mes)" +
                                                         " VALUES(@Emple,@Proye,@Tarea,@Mes)", this.__miconexionBD);
                    this.__micomandoSQL.Parameters.AddWithValue("@Emple", nombre);
                    this.__micomandoSQL.Parameters.AddWithValue("@Proye", proyecto);
                    this.__micomandoSQL.Parameters.AddWithValue("@Tarea", tarea);
                    this.__micomandoSQL.Parameters.AddWithValue("@Mes", mes);
                    this.__micomandoSQL.ExecuteNonQuery();
                    this.CerrarConexion();
                    this.DevolverHoras(nombre, proyecto, tarea, mes);
                }
            }
            catch { }

            return __horas;
        }

        public List<String> DevolverUsuarios()
        {
            List<String> __usuarios = new List<string>();
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand
            {
                Connection = this.__miconexionBD,
                CommandText = "SELECT Nombre FROM Usuarios"
            };

            SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
            try
            {
                while (resultadoSelect.Read())
                {
                    __usuarios.Add(resultadoSelect["Nombre"].ToString());
                }
            }
            finally
            {
                resultadoSelect.Close();
                this.CerrarConexion();
            }
            return __usuarios;
        }

        public void GuardarProyecto(Proyecto newProyecto)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand("INSERT INTO Proyectos (Nombre,Tipo,Cliente,Responsable,FechaInicio,FechaCierrePrevista,Observaciones)" +
                                                 " VALUES(@Nom,@Tipo,@Cliente,@Respo,@FecIni,@FecPreCi,@Obser)", this.__miconexionBD);
          
            this.__micomandoSQL.Parameters.AddWithValue("@Nom", newProyecto.Nombre);
            this.__micomandoSQL.Parameters.AddWithValue("@Tipo", newProyecto.Nombre);
            this.__micomandoSQL.Parameters.AddWithValue("@Cliente", newProyecto.Nombre);
            if (newProyecto.Responsable == null) { this.__micomandoSQL.Parameters.AddWithValue("@Respo", DBNull.Value); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@Respo", newProyecto.Responsable);  }
            if (newProyecto.FechaInicio == null) { this.__micomandoSQL.Parameters.AddWithValue("@FecIni", DateTime.Today); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@FecIni", newProyecto.FechaInicio); }
            if (newProyecto.FechaCierrePrevista == null) { this.__micomandoSQL.Parameters.AddWithValue("@FecPreCi", DBNull.Value); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@FecPreCi", newProyecto.FechaCierrePrevista); }
            if (newProyecto.Observaciones == null) { this.__micomandoSQL.Parameters.AddWithValue("@Obser", DBNull.Value); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@Obser", newProyecto.Observaciones); }

            this.__micomandoSQL.ExecuteNonQuery();
            
            this.CerrarConexion();
            
        }

        public void GuardarTarea(Tarea newTarea)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand("INSERT INTO Tareas (Nombre,Proyecto,FechaInicio,HorasEstimadas,Tecnico)" +
                                                 " VALUES(@Nom,@Proy,@FecIni,@HoEs,@Tecni)", this.__miconexionBD);

            this.__micomandoSQL.Parameters.AddWithValue("@Nom", newTarea.Nombre);
            this.__micomandoSQL.Parameters.AddWithValue("@Proy", newTarea.Proyecto);
            if (newTarea.FechaInicio == null) { this.__micomandoSQL.Parameters.AddWithValue("@FecIni", DateTime.Today); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@FecIni", newTarea.FechaInicio); }
            if (newTarea.HorasEstimadas.ToString() == null) { this.__micomandoSQL.Parameters.AddWithValue("@HoEs", DBNull.Value); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@HoEs", Convert.ToInt16(newTarea.HorasEstimadas)); }
            if (newTarea.Tecnico == null) { this.__micomandoSQL.Parameters.AddWithValue("@Tecni", DBNull.Value); }
            else { this.__micomandoSQL.Parameters.AddWithValue("@Tecni", newTarea.Tecnico); }
            this.__micomandoSQL.ExecuteNonQuery();

            this.CerrarConexion();

        }

        public void GuardarUser(Usuario newUser)
        {
            this.AbrirConexion();
            try
            {
                this.__micomandoSQL = new SqlCommand("INSERT INTO Usuarios (Nombre,Cargo,Password)" +
                                                     " VALUES(@Nom,@Cargo,@Pass)", this.__miconexionBD);
                this.__micomandoSQL.Parameters.AddWithValue("@Nom", newUser.Nombre);
                this.__micomandoSQL.Parameters.AddWithValue("@Cargo", newUser.Cargo);
                this.__micomandoSQL.Parameters.AddWithValue("@Pass", newUser.Password);
                this.__micomandoSQL.ExecuteNonQuery();
            }
            catch { }
            this.CerrarConexion();

        }

        public void BorrraProyecto(string nombre)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand("DELETE FROM Proyectos WHERE Nombre = @Nom", this.__miconexionBD);
            this.__micomandoSQL.Parameters.AddWithValue("@Nom", nombre);
            this.__micomandoSQL.ExecuteNonQuery();

            this.CerrarConexion();
        }

        public void BorrraTarea(string nombre)
        {
            this.AbrirConexion();

            this.__micomandoSQL = new SqlCommand("DELETE FROM Tareas WHERE Nombre = @Nom", this.__miconexionBD);
            this.__micomandoSQL.Parameters.AddWithValue("@Nom", nombre);
            this.__micomandoSQL.ExecuteNonQuery();

            this.CerrarConexion();
        }

        public Usuario ValidarUser(string Nombre, string Password)
        {
            this.AbrirConexion();

            SqlDataReader resultadoSelect;
            try
            {
                this.__micomandoSQL = new SqlCommand
                {
                    Connection = this.__miconexionBD,
                    CommandText = "SELECT * FROM Usuarios WHERE Password = '" + Password +
                                  "' and Nombre = '" + Nombre + "'"
                };
                resultadoSelect = this.__micomandoSQL.ExecuteReader();
            }
            catch
            {
                return null;
            }
            if (resultadoSelect.HasRows)
            {
                Usuario User = new Usuario();
                while (resultadoSelect.Read())
                {
                    User = new Usuario()
                    {
                        Nombre = resultadoSelect["Nombre"].ToString(),
                        Cargo = resultadoSelect["Cargo"].ToString(),
                    };
                }
                resultadoSelect.Close();
                this.CerrarConexion();
                return User;
            }
            else
            {
                resultadoSelect.Close();
                this.CerrarConexion();
                return null;
            }
        }

        public void ActualizarHoras(string empleado, string proyecto, string tarea, string mes, string dia, string horas, string comentario, string observacion)
        {
            this.AbrirConexion();
           // try
           // {
                //Ingreso los nuevos valores en al tabla Horas
                this.__micomandoSQL = new SqlCommand("Update Horas SET D" + dia + "=" + Convert.ToInt16(dia) +
                                                                    ", H" + dia + "=" + Convert.ToInt16(horas) +
                                                                    ", C" + dia + "= @Comen" +
                                                                    ", O" + dia + "= @Obser" +
                                                                    " WHERE Empleado ='" + empleado + "'" +
                                                                    " AND Proyecto ='" + proyecto + "'" +
                                                                    " AND Tarea ='" + tarea + "'" +
                                                                    " AND Mes ='" + mes + "'", this.__miconexionBD);
                if (comentario == null) { this.__micomandoSQL.Parameters.AddWithValue("@Comen", DBNull.Value); }
                else { this.__micomandoSQL.Parameters.AddWithValue("@Comen", comentario); }
                if (observacion == null) { this.__micomandoSQL.Parameters.AddWithValue("@Obser", DBNull.Value); }
                else { this.__micomandoSQL.Parameters.AddWithValue("@Obser", observacion); }
                this.__micomandoSQL.ExecuteNonQuery();

                //Actualizo Total en tabla Horas
                this.__micomandoSQL = new SqlCommand("Update Horas SET Total = H1+H2+H3+H4+H5+H6+H7+H8+H9+H10+H11+H12+H13+H14+H15+H16+H17+H18+H19+H20+H21+H22+H23+H24+H25+H26+H27+H28+H29+H30+H31", this.__miconexionBD);
                this.__micomandoSQL.ExecuteNonQuery();
            
                //Actualizo HorasReales de tabla Tareas
                this.__micomandoSQL = new SqlCommand();
                this.__micomandoSQL.Connection = this.__miconexionBD;
                this.__micomandoSQL.CommandText = "SELECT SUM(Total) FROM Horas WHERE Empleado = '"+empleado+"' AND Proyecto = '"+proyecto+"' AND Tarea = '"+tarea+"'";
                int total=0;
                SqlDataReader resultadoSelect = this.__micomandoSQL.ExecuteReader();
                if (resultadoSelect.Read())
                {
                    total = resultadoSelect.GetInt32(0);
                }
                resultadoSelect.Close();
                this.__micomandoSQL = new SqlCommand("Update Tareas SET HorasReales = "+total+" WHERE Nombre ='"+tarea+"' AND Proyecto = '"+proyecto+"' AND Tecnico = '"+empleado+"'", this.__miconexionBD);
                this.__micomandoSQL.ExecuteNonQuery();

                //Actualizo HorasReales de tabla Proyectos
                this.__micomandoSQL = new SqlCommand();
                this.__micomandoSQL.Connection = this.__miconexionBD;
                this.__micomandoSQL.CommandText = "SELECT SUM(HorasReales) FROM Tareas WHERE Proyecto = '" + proyecto +"'";
                int HReales = 0;
                resultadoSelect = this.__micomandoSQL.ExecuteReader();
                if (resultadoSelect.Read())
                {
                    HReales = resultadoSelect.GetInt32(0);
                }
                resultadoSelect.Close();
                this.__micomandoSQL = new SqlCommand("Update Proyectos SET HorasReales = " + HReales + " WHERE Nombre ='" + proyecto + "'", this.__miconexionBD);
                this.__micomandoSQL.ExecuteNonQuery();


            //}
            //catch { }
            this.CerrarConexion();
        }

        public void CerrarConexion()
        {
            this.__miconexionBD.Close();
        }

        #endregion
    }
}