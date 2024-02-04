import { Component, OnInit } from '@angular/core';
import { ItunesService } from './services/itunes/itunes.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  title = 'kawtharuna';
  public isExpanded = true;
  constructor() { }


  public toggleMenu() {
    this.isExpanded = !this.isExpanded;
  }


  ngOnInit() { }
}


