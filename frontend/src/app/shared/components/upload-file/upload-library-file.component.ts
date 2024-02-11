import { Component, EventEmitter, Input, OnInit, Output } from "@angular/core";

@Component({
  selector: "upload-library-file",
  templateUrl: "./upload-library-file.component.html",
  styleUrls: ["./upload-library-file.component.scss"],
})
export class UploadLibraryFileComponent {
  loadingMedia!: boolean;

  private _fileUrl!: string;
  private _fileName?: string;
  errorMsg?: string;

  get fileUrl() {
    return this._fileUrl;
  }

  get fileName() {
    return this._fileName;
  }

  get hasFile() {
    return this._fileName;
  }
  @Input() set fileUrl(value: string) {
    this._fileUrl = value;

  }

  @Output() newFile = new EventEmitter<any>();

  constructor() { }

  ngOnInit(): void { }

  onFileSelected(e: any) {
    this.loadingMedia = true;

    const file: File = e.target.files[0];
    this.errorMsg = "";
    if (!["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"].some(type => file.type === type)) {
      this.errorMsg = "Only PDF, DOC, and DOCX files are allowed.";
      this.loadingMedia = false;
      this._fileName = undefined;
      return;
    }
    this._fileName = file.name;
    this.newFile.emit(file);

    this.loadingMedia = false;

  }
}
