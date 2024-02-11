import { Component, OnInit } from '@angular/core';
import { ItunesService } from './services/itunes/itunes.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  title = 'kawtharuna';
  public isExpanded = true;

  constructor(private router: Router) {
    this.router.events.subscribe(event => {
      console.log('event is AppComponent ' + event);
    });
  }


  public toggleMenu() {
    this.isExpanded = !this.isExpanded;
  }


  ngOnInit() { }
}

