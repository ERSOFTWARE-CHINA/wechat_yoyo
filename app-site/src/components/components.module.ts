import { NgModule } from '@angular/core';
import { IonicModule } from 'ionic-angular';
import { OrderListSelectComponent } from './order-list-select/order-list-select';
@NgModule({
	declarations: [OrderListSelectComponent],
	imports: [
		IonicModule,
			],
	exports: [OrderListSelectComponent], 
	//entryComponents: [		OrderListSelectComponent,  	  ],

})
export class ComponentsModule {}
