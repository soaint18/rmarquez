import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-nologin',
  templateUrl: './../../vistas/noLogin.component.html'
})
export class NoLoginComponent {

    constructor( private _router: Router ) { }

    goRegistro() {
        this._router.navigate(['/registrocliente']);
      }

    goLogin() {
        this._router.navigate(['/logincliente']);
      }

    goEmpresa() {
    this._router.navigate(['/registroempresa']);
    }

}

