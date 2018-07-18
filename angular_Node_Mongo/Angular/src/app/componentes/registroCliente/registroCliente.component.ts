import { Component } from '@angular/core';
import { NgModel,  NgForm, FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { OperacionesServer } from '../../servicios/operacionesServer.service';

@Component({
  selector: 'app-registrocliente',
  templateUrl: './../../vistas/registroCliente.component.html'
})

export class RegistroClienteComponent {

    tiposReforma: Array<string>;
    public miformulario: FormGroup;

    constructor(
        private _operacionesServer: OperacionesServer,
        private _router: Router
    ) {
         this.tiposReforma = [
            'Pintura', 'Otros Trabajos', 'Instalación eléctrica', 'Instalación Fontanería', 'Reforma Vivienda', 'Mudanzas y transportes',
            'Yeso y pladur', 'Suelos', 'Manitas', 'Tapicería y Cortinas', 'Construcción', 'Albañilería', 'Puertas y Ventanas Metalicas',
            'Reforma Baño', 'Puertas y Ventanas de Madera', 'Gas y Calefacción', 'Parquet / Tarima', 'Bañera o Ducha', 'Muebles',
            'Carpintería de Madera'
        ];

        this.miformulario = new FormGroup({
            nombre: new FormControl('', Validators.required),
            apellidos: new FormControl('', Validators.required),
            email: new FormControl('', [Validators.required, Validators.pattern('.*@.*\.(com|es|arg)$')]),
            direccion: new FormControl('', Validators.required),
            tlfno: new FormControl('', [Validators.required, Validators.pattern('^[0-9]{9}$')]),
            cp: new FormControl('', [Validators.required, Validators.pattern('^[0-9]{5}$')]),
            provincia: new FormControl('', Validators.required),
            localidad: new FormControl('', Validators.required),
            tipo: new FormControl('', Validators.required),
            descripcion: new FormControl('', Validators.required)

        });
    }

    public guardarUsuario() {
        this.miformulario.addControl('password', new FormControl(Math.random().toString(36).substring(2, 15)));
        this._operacionesServer.registrarNuevoCliente(this.miformulario.value).subscribe(
            res => { if ( res.status === 200 ) {
                this._router.navigate(['/logincliente']);
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

