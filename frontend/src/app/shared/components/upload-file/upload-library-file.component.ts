import { Component, EventEmitter, Input, OnInit, Output } from "@angular/core";
import { Observable } from "rxjs";
import { finalize, map, takeUntil } from "rxjs/operators";
// import { ClearSubscriptionsComponent } from "src/app/shared/components/clear-subscriptions/clear-subscriptions.component";
// import { UploadHelperService } from "src/app/shared/services/upload-helper.service";

@Component({
  selector: "upload-library-file",
  templateUrl: "./upload-library-file.component.html",
  styleUrls: ["./upload-library-file.component.scss"],
})
export class UploadClubImageComponent
  extends ClearSubscriptionsComponent
  implements OnInit {
  loadingMedia!: boolean;
  imageUrl!: string;
  private _imageId!: string;
  errorMsg?: string;

  get imageId() {
    return this._imageId
  }
  @Input() set imageId(data: string) {
    this._imageId = data;
    this.getImage()
  }

  @Output() newImage = new EventEmitter<any>();

  constructor(private upload: UploadHelperService) {
    super();
  }

  ngOnInit(): void {
  }

  getImage() {
    this.upload.getFileData(this.imageId).pipe(map(res => res.url!))
      .pipe(takeUntil(this.destroy$))
      .subscribe(res => {
        this.imageUrl = res
      })
  }

  onFileSelected(e: any) {
    const file: File = e.target.files[0];
    this.errorMsg = "";
    if (!["png", "jpeg", "jpg"].some((type) => file.type.includes(type))) {
      this.errorMsg = "only images allowed to upload";
      return;
    }

    this.loadingMedia = true;
    this.upload.uploadAndSave(file, "images/clubs")
      .pipe(takeUntil(this.destroy$), finalize(() => this.loadingMedia = false))
      .subscribe(res => {
        this.loadingMedia = false;
        this.newImage.emit(res.id);
        this.imageUrl = res.url
      })
  }
}
