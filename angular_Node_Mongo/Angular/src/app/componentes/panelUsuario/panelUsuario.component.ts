import { Globals } from './../../servicios/global.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { OperacionesServer } from '../../servicios/operacionesServer.service';
import { Cliente } from '../../modelos/cliente';
import { Reforma } from '../../modelos/reforma';
import { forEach } from '@angular/router/src/utils/collection';


@Component({
  selector: 'app-panelusu',
  templateUrl: './../../vistas/panelUsuario.component.html'
})
export class PanelUsuarioComponent implements OnInit {

    public reformas: Array<Reforma>;
    public nombre: string;

    constructor(
        private _operacionesServer: OperacionesServer,
        private _router: Router,
        private _global: Globals
        ) { this.reformas = new Array<Reforma>(); }

    ngOnInit() {
        if (this._global.usuario === null || this._global.usuario === undefined) {
            this._router.navigate(['/logincliente']);
        } else { this.nombre = this._global.usuario.nombre; }

        this._operacionesServer.recuperarReformas(this.nombre).subscribe(
            res => {
                this.reformas = res;
            },
            error => {
                console.log('ERROR ----> ' + error);
                this._router.navigate(['/errorserver']);
            }
        );

        console.log(this._global.usuario);
    }

    logout() {
        this._global.usuario = null;
        this._router.navigate(['/']);
    }

}

