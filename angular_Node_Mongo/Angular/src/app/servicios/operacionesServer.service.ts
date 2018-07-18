import { Injectable } from '@angular/core';
import { Cliente } from '../modelos/cliente';
import { Empresa } from '../modelos/empresa';
import { Reforma } from '../modelos/reforma';
import { Http, Headers, Response } from '@angular/http';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';


@Injectable()
export class OperacionesServer {

    private __urlServer = 'http://localhost:3000';

    constructor( private _http: Http ) {}

    // ------Metodos GET contra el servidor-----
    public devolverMaterias() {
        // Con el .map() final estamos mapeando los objetos Promise del Flujo en objetos JSON
        // Seria como el json.parse()
        return this._http.get( this.__urlServer + '/devolverMaterias' ).map( respuesta => respuesta.json() );
    }

    // ------Metodos POST contra el servidor-----

    public registrarNuevoCliente( nuevoCliente: Cliente ) {
        const datos: string = JSON.stringify(nuevoCliente);
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/registraUsuario', datos, {headers: cabeceras});
    }

    public registrarNuevaEmpresa( nuevaEmpresa: Empresa ) {
        const datos: string = JSON.stringify(nuevaEmpresa);
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/registraEmpresa', datos, {headers: cabeceras});
    }

    public registrarNuevaReforma( nuevaReforma: Reforma ) {
        const datos: string = JSON.stringify(nuevaReforma);
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/registraReforma', datos, {headers: cabeceras});
    }

    public validarUsuario( nuevoCliente: Cliente ) {
        const datos: string = JSON.stringify(nuevoCliente);
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/compruebaLogin', datos, {headers: cabeceras} )
        .map( respuesta => respuesta.json() );
    }

    public recuperarReformas( nombre: string ) {
        const datos: string = JSON.stringify( { nombre: nombre } );
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/recuperarReformas', datos, {headers: cabeceras} )
        .map( respuesta => respuesta.json() );
    }

    public modificarCliente( nuevoCliente: Cliente ) {
        const datos: string = JSON.stringify(nuevoCliente);
        const params = 'json=' + datos;
        const cabeceras: Headers = new Headers({'Content-type': 'application/x-www-form-urlencoded'});
        return this._http.post(this.__urlServer + '/modificarUsuario', datos, {headers: cabeceras});
    }

}

