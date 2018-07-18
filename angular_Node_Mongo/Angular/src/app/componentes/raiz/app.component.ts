import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Globals } from './../../servicios/global.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {

  constructor(
    private _router: Router,
    private _global: Globals
    ) { }

  ngOnInit() {

  }

  login() {
    this._global.empresa = null;
    this._global.usuario = null;
  }

}
