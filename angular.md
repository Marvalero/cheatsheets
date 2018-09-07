# Getting started: one-first-app
 - Create project:
```
ng new one-first-app
```
 - Install Bootstrap:
```
npm install --save bootstrap@3
```
and add `"node_modules/bootstrap/dist/css/bootstrap.min.css",` to angular.json styles
- Serve Page:
```
ng serve
```

- Create Component:
```
ng g c newcomponentmaria
```

# Basics: two-components
 - Create component (and declare it in app.module.ts)
 - component properties: selector, template, styles
 - Data binding:
   * string interpolation: {{ myVar }}
   * property binding: [hide]="myBool"
   * event binding: (click)="onUpdateServerName($event)"
   * two way data binding: [(ngModel)]="serverStatus"
 - Directives:
   * \*ngIf="myBool"
   * ngSwitch="value"   \*ngSwitchCase="5" \*ngSwitchDefault
   * \*ngFor="let server of servers; let i = index"
   * ngSwitch="value"
   * [ngStyle]="{ backgroundColor: getColor() }"
   * [ngClass]="{ online: serverStatus === 'online' }">

# DataBinding: cmp-databinding-start
 - Get input in a component: `@Input('maria') element: { type: string, name: string, content: string };`
 - Export event: ` @Output('bpCreated') blueprintCreated = new EventEmitter<{ serverName: string, serverContent: string }>();`
                 `this.blueprintCreated.emit({ serverName: name.value, serverContent: this.serverContentInput.nativeElement.value });`
 - CSS: `ViewEncapsulation`. It can be None, Emulated, Native
 - local reference to a html element: `<input type="text" class="form-control" #serverNameInput>`
 - View local reference: `@ViewChild('serverContentInput') serverContent: ElementRef;`
 - render parent html elements, it is like a html hook: <ng-content></ng-content>
 - View local reference to contentchild (from ng-content): `@ContentChild('contentChild') paragraph: ElementRef;`
 - Component Life cycle hooks:
   * ngOnChanges(): Respond when Angular (re)sets data-bound input properties.
   * ngOnInit(): when component is created
   * ngDoCheck(): when something changes in the template or events.
   * ngAfterContentInit(): after <ng-content></ng-content> is added
   * ngAfterContentChecked(): Respond after Angular checks the content projected
   * ngAfterViewInit(): after the view is being initialized
   * ngAfterViewChecked(): Respond after Angular checks the component's views and child view
   * ngOnDestroy(): before the view is destroyed

# Directives Deep Dive: exec-game-bind **share code/functionality between elements**
 - attribute directives: properties (possible using databinding or event binding)
 - structural directives: affects the DOM. It is normal directive but with *
 - Create attribute directive:
     `@Directive({ selector: '[appBasicHighlight]' })`
     `constructor(private elementRef: ElementRef) {}`
 - Create directive: `ng g d better-highlight`
 - Use Renderer2 to change style:
    `constructor(private elRef: ElementRef, private renderer: Renderer2) { }`
    `this.renderer.setStyle(this.elRef.nativeElement, 'background-color', 'black');`
 - Listen events on object: `@HostListener('mouseenter') mouseOver(eventData: Event) { }`
 - Bind to a property: `@HostBinding('style.fontWeight') fontWeight: string;`
 - Create structural directive:
 ` @Input('Unless') set appUnless(condition: boolean) {
     if(!condition) {
       this.vcRef.createEmbeddedView(this.templateRef);
     } else {
       this.vcRef.clear();
     }
   }`

# Services and Dependency Injection: services-start
 - Services: are a great way to share information among classes that don't know each other. Components shouldn't fetch or save data directly and they certainly shouldn't knowingly present fake data. They should focus on presenting data and delegate data access to a service.
 - Hirarchical Injector: if we write in the constructor that we need an instance of an object, angular will try to give it to us:
  `constructor(private mariaService: MariaService) {}`
    you need to specify tho, the instance that you will need using *providers*:
    ```
    @Component({
      selector: 'app-something',
      templateUrl: './something.component.html',
      styleUrls: ['./something.component.css'],
      providers: [MariaService]
    })
    ```
 - Share instances using Hirarchical Injector: instances propagates to childs. You can do it:
   * AppModule: instance available application-wide
   * AppComponent: instance available for all components (but not other services)
   * Any other component: same instance will be available for its childs.
If you dont want angular to create a new instance, jsut remove that service from **providers**.
 - Use services in other services: you need to add the contructor and add metadata in the service `@Injectable({})`
  - Lazy load modules: `@Injectable({providedIn: 'root'})`

# Router: routing-star
 - A router is used to use a different url so it looks like several pages
 - Router: it is defined in app.module.ts:
   a) create constant
       `const appRoutes: Routes =[
         { path: '', component: HomeComponent },
         { path: 'users', component: UsersComponent },
         { path: 'servers', component: ServersComponent },
       ];`
      * you can add children to the route: `{ path: 'servers', component: ServersComponent, children: [{ path: ':id', component: ServerComponent }]}`
      * you can use `redirectTo` to redirect to another path
      * you can use a guard with `canActivate: [AuthGuard]` or `canActivateChild: [AuthGuard]` or `canDeactivate: [CanDeactivateGuard]`
      * Data:
        - Fixed data: `data: { somedata: 'true' }` to pass data to a route (probably to use it in different parts with different configuration)
        - Load data: `resolve: { server: ServerResolver }`
   b) add `RouterModule.forRoot(appRoutes)` to imports
      * Has routes: use `RouterModule.forRoot(appRoutes, { useHash: true })`
   c) use <router-outlet></router-outlet> where you want to render your router components
   d) use `routerLink="/users"` property to navigate using the router. If you dont start with `/` it will be a relative path
  - Router in html:
    * `routerLinkActive="active"` to set the active class when route is that one
    * `[routerLinkActiveOptions]="{}"` to configure options
    * queryParams: `[queryParams]="{allowEdit: '1'}"`
    * fragment: `fragment="loading"`
  - Router in ts:
     * `constructor(private router: Router) { }`: add it to your constructor
     * `this.router.navigate(['/servers']);`: use navigate to swap page, this router doesnt know where we are, so you need to pass options to use relative paths: `this.router.navigate(['servers'], {relativeTo: this.route});` where this.route can be created in the constructor as `private route: ActivatedRoute`
     * queryParams: `this.router.navigate(['servers'], {queryParams: {allowEdit: '1'}});`
     * fragment: `this.router.navigate(['servers'], {fragment: 'blabla'});`
     * queryParamsHandling: defines how our query params will be passed. It can be 'merge', 'preserve',...
  - Dynamic path: use :name
      a) set it `const appRoutes: Routes =[{ path: 'users/:id', component: UserComponent }]`
      b) read the value using ActivatedRoute: `this.activatedroute.snapshot.params['id']`
  - Observable: it is a JS tool to control asynchronous calls. The Observable object represents the object that sends notifications (the provider); the Observer object represents the class that receives them (the observer).
    We can subscribe to changes on parameters, queryParams or fragment:
    ```
    this.route.params.subscribe(
      (params: Params) => { this.user.id = params['id']; this.user.name = params['name']; }
    );
    this.route.queryParams.subscribe()
    this.route.fragment.subscribe()
    ```
    * Note: this observables are cleaned up by Angular. But if you create your own Observable, you would need to unsubscribe to it OnDestroy
  - Guards: service that `implements CanActivate` or `implements CanActivateChild`.
    * Maybe we want to wanr the user form leaving a page `implements CanDeactivate<CanComponentDeactivate>`


# Observable: observables-start
  - Observable Definition: observable are used to read from a data source.
    * Historically, you may have use callbacks or promises for this.
    * Defined in module rxjs
    * Use old way of install things (optional): `pm install --save rxjs-compat`
    * You write code for:
      1. handle data
      2. handle error (some observable never error, like getting params in the url)
      3. handle completion (some observable never complete)
 - Example:
       ```
       const customObservable = Observable.create(
         (observer: Observer<string>) => {
           setTimeout(() => {
             observer.next('first package')
           },2000)
           setTimeout(() => {
             observer.next('second package')
           },4000)
           setTimeout(() => {
             observer.error('this didnt work')
             // observer.complete()
           },5000)
         }
       );
       this.customObservableSubscription = customObservable.subscribe(
         (value: string) => { console.log(value); },
         (error: string) => { console.log(error); },
         () => { console.log('completed'); }
       )
       ```
 - OnDestroy: remember you need to clear your Subscriptions
      ```
      ngOnDestroy() {
        this.customObservableSubscription.unsubscribe();
      }
      ```
 - Subjects Definition: like an observable but you push data and Subscriptors will get that data.
      ```
      onActivate() {
        this.userService.userActivated.next(this.id);
      }
      ```
      then subscriptors:
      ```
      ngOnInit() {
        this.userService.userActivated.subscribe(
          (id: number) => {
            if (id == 1) {
              this.User1Activated = true;
            } else {
              this.User1Activated = false;
            }
          }
        );
      }
      ```
  - Operator: they return new observables but modified. Example: `interval(2000).pipe(map((data: number) { return data*2; }))`


# Forms:
  - two approaches:
    * template-driven (angular infers the Form Object from the DOM)
    * reactive-approach (Form created programatically and synchronised with the DOM)

# final-project
