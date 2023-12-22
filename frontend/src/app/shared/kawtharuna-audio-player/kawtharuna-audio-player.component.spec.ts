import { ComponentFixture, TestBed } from '@angular/core/testing';

import { KawtharunaAudioPlayerComponent } from './kawtharuna-audio-player.component';

describe('KawtharunaAudioPlayerComponent', () => {
  let component: KawtharunaAudioPlayerComponent;
  let fixture: ComponentFixture<KawtharunaAudioPlayerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [KawtharunaAudioPlayerComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(KawtharunaAudioPlayerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
