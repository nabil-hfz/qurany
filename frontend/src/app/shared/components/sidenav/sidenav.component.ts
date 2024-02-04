import { Component, Input, Output, EventEmitter } from "@angular/core";

@Component({
  selector: "side-nav",
  styleUrls: ["sidenav.component.scss"],
  templateUrl: './sidenav.component.html',
})
export class SidenavComponent {
  @Input() isExpanded: boolean | undefined = false;
  @Output() toggleMenu = new EventEmitter();

  sideWidth = this.isExpanded ? "300px" : "auto";
  public routeLinks = [
    { link: "./khatma", name: "Khatma", icon: "dashboard" },
    { link: "./library", name: "Library", icon: "account_balance" },
  ];
}