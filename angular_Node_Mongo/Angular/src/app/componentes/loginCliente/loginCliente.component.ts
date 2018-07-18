import { Globals } from './../../servicios/global.service';
import { Component } from '@angular/core';
import { NgModel,  NgForm, FormGroup, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { OperacionesServer } from '../../servicios/operacionesServer.service';
import { Cliente } from '../../modelos/cliente';
import { Empresa } from '../../modelos/empresa';

@Component({
  selector: 'app-logincliente',
  templateUrl: './../../vistas/loginCliente.component.html'
})

export class LoginClienteComponent {

  private login: string;
  private password: string;
  public miformulario: FormGroup;

  constructor(
    private _operacionesServer: OperacionesServer,
    private _router: Router,
    private _global: Globals
    ) {
      this.miformulario = new FormGroup({
        email: new FormControl('', Validators.required),
        password: new FormControl('', Validators.required),
      });
  }

  public vaidarUsuario() {
    this._operacionesServer.validarUsuario(this.miformulario.value).subscribe(
        res => {
          if (!res.cif) {
            this._global.usuario = new Cliente(res.nombre, res.apellidos, res.direccion,
                                               res.localidad, res.provincia, res.cp, res.email,
                                               res.tlfno, res.password);
            this._router.navigate(['/panelusuario']);
          } else {
            this._global.empresa = new Empresa(res.nombre, res.cif, res.direccion, res.localidad,
                                               res.provincia, res.cp, res.email, res.tlfno,
                                               res.password, res.tipo);
            this._router.navigate(['/panelempresa']);
          }
        },
        error => {
          if ( error.status === 404 ) {
            this._router.navigate(['/nologin']);
          } else {
            console.log('ERROR ----> ' + error);
            this._router.navigate(['/errorserver']);
          }
        }
    );

    this.miformulario.reset();
  }

  goRegistro() {
    this._router.navigate(['/registrocliente']);
  }

  goEmpresa() {
    this._router.navigate(['/registroempresa']);
  }

}
