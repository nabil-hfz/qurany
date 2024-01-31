import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-ask-dialog',
  templateUrl: './ask-dialog.component.html',
  styleUrls: ['./ask-dialog.component.scss']
})
export class AskDialogComponent implements OnInit {

  constructor(
    public dialogRef: MatDialogRef<AskDialogComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: { message: string;}
  ) { }

  ngOnInit(): void { }

  confirm() {
    this.dialogRef.close({ confirmed: true });
  }

  close() {
    this.dialogRef.close({ confirmed: false });
  }
}
