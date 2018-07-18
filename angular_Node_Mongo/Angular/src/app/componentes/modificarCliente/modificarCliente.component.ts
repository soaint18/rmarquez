import { Component } from '@angular/core';
import { NgModel,  NgForm, FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { OperacionesServer } from '../../servicios/operacionesServer.service';
import { Globals } from '../../servicios/global.service';
import { Cliente } from './../../modelos/cliente';

@Component({
  selector: 'app-modificarcliente',
  templateUrl: './../../vistas/modificarCliente.component.html'
})

export class ModificarClienteComponent {

    public miformulario: FormGroup;
    public usuario: Cliente;

    constructor(
        private _operacionesServer: OperacionesServer,
        private _router: Router,
        private _global: Globals
    ) {
        if (this._global.usuario === null || this._global.usuario === undefined) {
            this._router.navigate(['/logincliente']);
        } else { this.usuario = this._global.usuario; }

        this.miformulario = new FormGroup({
            nombre: new FormControl('', Validators.required),
            apellidos: new FormControl('', Validators.required),
            email: new FormControl('', [Validators.required, Validators.pattern('.*@.*\.(com|es|arg)$')]),
            password: new FormControl('', Validators.required),
            direccion: new FormControl('', Validators.required),
            tlfno: new FormControl('', [Validators.required, Validators.pattern('^[0-9]{9}$')]),
            cp: new FormControl('', [Validators.required, Validators.pattern('^[0-9]{5}$')]),
            provincia: new FormControl('', Validators.required),
            localidad: new FormControl('', Validators.required),
        });
    }

    public guardarUsuario() {
        this._operacionesServer.modificarCliente(this.miformulario.value).subscribe(
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
    }

}

