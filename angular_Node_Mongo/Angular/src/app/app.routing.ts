import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

// Componentes de la aplicacion
import { Error404Component } from './componentes/error404/error404.component';
import { ErrorServerComponent } from './componentes/errorServer/errorServer.component';
import { AppComponent } from './componentes/raiz/app.component';
import { HomeComponent } from './componentes/home/home.component';
import { LoginClienteComponent } from './componentes/loginCliente/loginCliente.component';
import { NoLoginComponent } from './componentes/noLogin/noLogin.component';
import { RegistroClienteComponent } from './componentes/registroCliente/registroCliente.component';
import { RegistroEmpresaComponent } from './componentes/registroEmpresa/registroEmpresa.component';
import { PanelEmpresaComponent } from './componentes/panelEmpresa/panelEmpresa.component';
import { PanelUsuarioComponent } from './componentes/panelUsuario/panelUsuario.component';
import { RegistraReformaComponent } from './componentes/registrarReforma/registrarReforma.component';
import { ModificarClienteComponent } from './componentes/modificarCliente/modificarCliente.component';

const rutas: Routes = [
    { path: '', component: HomeComponent },
    { path: 'home', component: HomeComponent },
    { path: 'logincliente', component: LoginClienteComponent },
    { path: 'nologin', component: NoLoginComponent },
    { path: 'registrocliente', component: RegistroClienteComponent },
    { path: 'registroempresa', component: RegistroEmpresaComponent },
    { path: 'panelusuario', component: PanelUsuarioComponent },
    { path: 'registrareforma', component: RegistraReformaComponent },
    { path: 'modificarcliente', component: ModificarClienteComponent },
    { path: 'panelempresa', component: PanelEmpresaComponent },
    { path: 'errorserver', component: ErrorServerComponent },
    { path: '**', component: Error404Component },
];

@NgModule({
    imports: [RouterModule.forRoot(rutas)],
    exports: [RouterModule]
})

export class AppRoutingModule { }
