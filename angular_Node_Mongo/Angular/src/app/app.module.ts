import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { AppRoutingModule } from './app.routing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';

// Componentes
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

// Servicios
import { OperacionesServer } from './servicios/operacionesServer.service';
import { Globals } from './../app/servicios/global.service';



@NgModule({
  declarations: [
    Error404Component,
    ErrorServerComponent,
    AppComponent,
    HomeComponent,
    LoginClienteComponent,
    NoLoginComponent,
    RegistroClienteComponent,
    RegistroEmpresaComponent,
    PanelUsuarioComponent,
    PanelEmpresaComponent,
    RegistraReformaComponent,
    ModificarClienteComponent
  ],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    BrowserModule,
    HttpClientModule,
    HttpModule,
    AppRoutingModule
  ],
  providers: [ OperacionesServer, Globals ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
