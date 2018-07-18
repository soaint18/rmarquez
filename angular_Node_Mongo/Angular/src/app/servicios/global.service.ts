import { Injectable } from '@angular/core';
import { Cliente } from '../modelos/cliente';
import { Empresa } from '../modelos/empresa';

@Injectable()
export class Globals {
  usuario: Cliente;
  empresa: Empresa;

}
