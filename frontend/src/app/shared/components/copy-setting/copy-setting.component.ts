import { Component, Inject, Input, OnInit } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material/dialog";

@Component({
  selector: "app-copy-setting",
  templateUrl: "./copy-setting.component.html",
  styleUrls: ["./copy-setting.component.scss"],
})
export class CopySettingComponent implements OnInit {
  settings:any[] = [];
  list: any[] = []
  constructor(
    public dialogRef: MatDialogRef<CopySettingComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: { settings: { label: string; key: string; checked: boolean }[] }
  ) { }

  ngOnInit(): void {
    this.settings = this.data.settings
  }

  selectChange(event: any) {
  }

  save() {
    this.dialogRef.close({ list: this.list })
  }
}
