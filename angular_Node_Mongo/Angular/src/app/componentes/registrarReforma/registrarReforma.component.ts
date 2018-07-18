import { Reforma } from './../../modelos/reforma';
import { Cliente } from './../../modelos/cliente';
import { Component } from '@angular/core';
import { NgModel,  NgForm, FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { OperacionesServer } from '../../servicios/operacionesServer.service';
import { Globals } from '../../servicios/global.service';


@Component({
  selector: 'app-registrareforma',
  templateUrl: './../../vistas/registrarReforma.component.html'
})

export class RegistraReformaComponent {

    tiposReforma: Array<string>;
    miformulario: FormGroup;
    usuario: Cliente;

    constructor(
        private _operacionesServer: OperacionesServer,
        private _router: Router,
        private _global: Globals
    ) {
        if (this._global.usuario === null || this._global.usuario === undefined) {
            this._router.navigate(['/logincliente']);
        }

        this.tiposReforma = [
            'Pintura', 'Otros Trabajos', 'Instalación eléctrica', 'Instalación Fontanería', 'Reforma Vivienda', 'Mudanzas y transportes',
            'Yeso y pladur', 'Suelos', 'Manitas', 'Tapicería y Cortinas', 'Construcción', 'Albañilería', 'Puertas y Ventanas Metalicas',
            'Reforma Baño', 'Puertas y Ventanas de Madera', 'Gas y Calefacción', 'Parquet / Tarima', 'Bañera o Ducha', 'Muebles',
            'Carpintería de Madera'
        ];

        this.usuario = this._global.usuario;

        this.miformulario = new FormGroup({
            tipo: new FormControl('', Validators.required),
            descripcion: new FormControl('', Validators.required),
        });
    }

    public guardarReforma() {
        this.miformulario.addControl('cliente', new FormControl(this.usuario.nombre));
        this.miformulario.addControl('empresa', new FormControl(''));
        this.miformulario.addControl('presupuesto', new FormControl(''));
        this._operacionesServer.registrarNuevaReforma(this.miformulario.value).subscribe(
            res => { if ( res.status === 200 ) {
                this._router.navigate(['/panelusuario']);
            } else {
                this._router.navigate(['/errorserver']);
            }
            },
            error => {
                console.log('ERROR ----> ' + error);
                this._router.navigate(['/errorserver']);
            }
        );
        this.miformulario.reset();
    }

}