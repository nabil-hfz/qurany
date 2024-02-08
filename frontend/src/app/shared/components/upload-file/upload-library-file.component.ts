import { Component, EventEmitter, Input, OnInit, Output } from "@angular/core";

@Component({
  selector: "upload-library-file",
  templateUrl: "./upload-library-file.component.html",
  styleUrls: ["./upload-library-file.component.scss"],
})
export class UploadLibraryFileComponent {
  loadingMedia!: boolean;

  private _fileId!: string;
  errorMsg?: string;

  get fileId() {
    return this._fileId;
  }

  @Input() set fileId(data: string) {
    this._fileId = data;

  }

  @Output() newFile = new EventEmitter<any>();

  constructor() { }

  ngOnInit(): void { }

  onFileSelected(e: any) {
    const file: File = e.target.files[0];
    this.errorMsg = "";
    if (!["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"].some(type => file.type === type)) {
      this.errorMsg = "Only PDF, DOC, and DOCX files are allowed.";
      return;
    }

    // Your file upload logic here
    this.loadingMedia = true;


    
    // Example: Upload the file and emit the event
    // this.upload.uploadAndSave(file, "docs/library")
    //   .subscribe(res => {
    //     this.loadingMedia = false;
    //     this.newFile.emit(res.id);
    //     // Handle the file URL or ID as needed
    //   }, error => {
    //     this.loadingMedia = false;
    //     this.errorMsg = "Error uploading file";
    //   });
  }
}
