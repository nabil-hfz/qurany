import { Component, ContentChildren, EventEmitter, Input, OnInit, Output, QueryList, ViewChild } from "@angular/core";
import { MatColumnDef, MatTable } from "@angular/material/table";

export interface ActionPermissions {
  edit?: string;
  view?: string;
  delete?: string;
}

export interface DataColumn {
  columnName: string;
  type: "text" | "description" | "date" | "status" | "avatar" | "actions" | "boolean";
  columnLabel: string;
  sortBy?: string;
  path?: string; // you can access to data column by column name
  cssClasses?: string;
}

@Component({
  selector: "app-table",
  templateUrl: "./table.component.html",
  styleUrls: ["./table.component.scss"],
})
export class TableComponent implements OnInit {
  @Input() displayedColumns: string[] = [];
  @Input() dataTable!: DataColumn[];
  @Input() data: any[] = [];
  @Input() actionsPermission!: ActionPermissions;

  @Output() onScroll = new EventEmitter<any>();
  @Output() onSort = new EventEmitter<{
    orderBy: string;
    orderDir: "asc" | "desc";
  }>();

  // this is where the magic happens: 
  @ViewChild(MatTable, { static: true }) table!: MatTable<any>;
  @ContentChildren(MatColumnDef) columnDefs!: QueryList<MatColumnDef>;

  defaultMedia = "assets/images/users/thumb-2.png";

  constructor() {}

  ngOnInit(): void {
  }

  get textCols() {
    return this.dataTable.filter((col) =>
      ["description", "text", "date"].includes(col.type)
    );
  }

  get avatarCols() {
    return this.dataTable.filter((col) => col.type === "avatar");
  }

  get statusCols() {
    return this.dataTable.filter((col) => col.type === "status");
  }

  ngAfterContentInit(): void {
    //Called after ngOnInit when the component's or directive's content has been initialized.
    //Add 'implements AfterContentInit' to the class.
    this.columnDefs.forEach(columnDef => this.table.addColumnDef(columnDef));
  }

}
