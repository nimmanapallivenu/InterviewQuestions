# Frontend Development Interview Questions - Top 200

## 📚 Table of Contents
1. [HTML5 (Q1-Q30)](#html5-questions)
2. [CSS3 & Responsive Design (Q31-Q60)](#css3-questions)
3. [JavaScript Fundamentals (Q61-Q90)](#javascript-questions)
4. [ES6+ & TypeScript (Q91-Q120)](#es6-typescript)
5. [React (Q121-Q160)](#react-questions)
6. [Angular (Q161-Q200)](#angular-questions)

---

## HTML5 Questions

### Q1-Q10: HTML5 Fundamentals
**Q1: What are semantic HTML elements?**
```html
<header>, <nav>, <main>, <article>, <section>, <aside>, <footer>
Benefits: Better SEO, accessibility, code readability
```

**Q2: HTML5 new features?**
- Semantic elements, Audio/Video, Canvas, SVG, Local Storage, Geolocation, Web Workers, WebSocket

**Q3: localStorage vs sessionStorage?**
```javascript
localStorage.setItem('key', 'value'); // Persists
sessionStorage.setItem('key', 'value'); // Tab session only
```

**Q4: data-* attributes?**
```html
<div data-user-id="123" data-role="admin"></div>
<script>
  element.dataset.userId; // "123"
</script>
```

**Q5: Form validation?**
```html
<input type="email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
```

**Q6-Q10:** DOCTYPE, Meta tags, ARIA, Canvas vs SVG, iframe

### Q11-Q20: Advanced HTML
**Q11: Web Workers?** Background JavaScript threads
**Q12: Service Workers?** Offline functionality, PWA
**Q13: Geolocation API?** navigator.geolocation.getCurrentPosition()
**Q14: Drag and Drop?** draggable attribute, drag events
**Q15: Audio/Video API?** play(), pause(), currentTime
**Q16: Form elements?** input types (email, date, range, color)
**Q17: Picture element?** Responsive images
**Q18: Template element?** Reusable HTML fragments
**Q19: Details/Summary?** Collapsible content
**Q20: Custom elements?** Web Components

### Q21-Q30: HTML Best Practices
- Semantic markup
- Accessibility (alt text, ARIA labels)
- SEO optimization
- Performance (lazy loading, async scripts)
- Cross-browser compatibility
- Mobile-first approach
- Valid HTML structure
- Proper heading hierarchy
- Form accessibility
- Progressive enhancement

---

## CSS3 Questions

### Q31: CSS Box Model?
```css
.box {
  width: 200px;
  padding: 20px;
  border: 5px solid;
  margin: 10px;
  box-sizing: border-box; /* width includes padding and border */
}
```

### Q32: Flexbox?
```css
.container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
}
.item { flex: 1; }
```

### Q33: CSS Grid?
```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  grid-template-areas:
    "header header header"
    "sidebar main main"
    "footer footer footer";
}
```

### Q34: Positioning?
```css
position: static | relative | absolute | fixed | sticky;
```

### Q35: Media Queries?
```css
@media (min-width: 768px) { /* Tablet */ }
@media (min-width: 1024px) { /* Desktop */ }
```

### Q36: Animations & Transitions?
```css
.button {
  transition: all 0.3s ease;
}
@keyframes slideIn {
  from { transform: translateX(-100%); }
  to { transform: translateX(0); }
}
.animated { animation: slideIn 0.5s; }
```

### Q37: CSS Specificity?
```
Inline: 1000, ID: 100, Class: 10, Element: 1
```

### Q38: CSS Variables?
```css
:root {
  --primary-color: #3498db;
}
.button { background: var(--primary-color); }
```

### Q39: Pseudo-classes vs Pseudo-elements?
```css
a:hover { } /* Pseudo-class - state */
p::first-letter { } /* Pseudo-element - part */
```

### Q40: SASS/SCSS?
```scss
$primary: #3498db;
.nav {
  ul { margin: 0; }
  li { display: inline; }
}
@mixin flex-center {
  display: flex;
  justify-content: center;
}
```

### Q41-Q60: CSS Concepts
- BEM methodology
- CSS Modules
- Styled Components
- Tailwind CSS
- Bootstrap
- CSS Reset vs Normalize
- Z-index stacking
- Overflow handling
- Display property
- Float and clear
- CSS counters
- Filters and blend modes
- CSS shapes
- Container queries
- Responsive typography
- Mobile-first design
- Cross-browser compatibility
- Performance optimization
- CSS architecture
- Naming conventions

---

## JavaScript Questions

### Q61: Data Types?
```javascript
Primitives: string, number, boolean, undefined, null, symbol, bigint
Reference: object, array, function
```

### Q62: var vs let vs const?
```javascript
var: function-scoped, hoisted
let: block-scoped
const: block-scoped, immutable binding
```

### Q63: Closures?
```javascript
function outer() {
  let count = 0;
  return function inner() {
    return ++count;
  };
}
const counter = outer();
counter(); // 1
counter(); // 2
```

### Q64: Promises & Async/Await?
```javascript
const fetchData = () => new Promise((resolve, reject) => {
  setTimeout(() => resolve("Data"), 1000);
});

async function getData() {
  try {
    const data = await fetchData();
    return data;
  } catch (error) {
    console.error(error);
  }
}
```

### Q65: Event Loop?
```javascript
console.log('1');
setTimeout(() => console.log('2'), 0);
Promise.resolve().then(() => console.log('3'));
console.log('4');
// Output: 1, 4, 3, 2
```

### Q66: this Keyword?
```javascript
// Global: window
// Object method: object
// Arrow function: lexical this
// call/apply/bind: explicit binding
```

### Q67: Prototypal Inheritance?
```javascript
function Person(name) {
  this.name = name;
}
Person.prototype.greet = function() {
  return `Hello, ${this.name}`;
};
```

### Q68: Array Methods?
```javascript
map, filter, reduce, find, some, every, forEach
const doubled = arr.map(n => n * 2);
const evens = arr.filter(n => n % 2 === 0);
const sum = arr.reduce((acc, n) => acc + n, 0);
```

### Q69: Destructuring?
```javascript
const [a, b, ...rest] = [1, 2, 3, 4];
const { name, age } = { name: "John", age: 30 };
```

### Q70: Spread & Rest?
```javascript
const arr = [...arr1, ...arr2];
const obj = { ...obj1, ...obj2 };
function sum(...numbers) { }
```

### Q71-Q90: JavaScript Concepts
- Hoisting
- Event delegation
- Debouncing & throttling
- Deep vs shallow copy
- Currying
- Memoization
- Generator functions
- Iterators
- Proxy & Reflect
- WeakMap & WeakSet
- Regular expressions
- Error handling
- Modules (import/export)
- JSON methods
- LocalStorage API
- Fetch API
- DOM manipulation
- Event handling
- AJAX & XMLHttpRequest
- Web APIs

---

## ES6+ & TypeScript

### Q91: Arrow Functions?
```javascript
const add = (a, b) => a + b;
const square = x => x * x;
```

### Q92: Template Literals?
```javascript
const name = "John";
const message = `Hello, ${name}!`;
```

### Q93: Modules?
```javascript
export const PI = 3.14;
export default class User { }
import User, { PI } from './module.js';
```

### Q94: Classes?
```javascript
class Person {
  constructor(name) { this.name = name; }
  greet() { return `Hello, ${this.name}`; }
}
class Employee extends Person { }
```

### Q95: Destructuring Advanced?
```javascript
const { name: userName, age = 0 } = user;
const [a, b, ...rest] = array;
```

### Q96-Q100: ES6+ Features
- Optional chaining (?.)
- Nullish coalescing (??)
- Promise.allSettled()
- Array.flat(), flatMap()
- Object.entries(), values()

### Q101: TypeScript Basics?
```typescript
let name: string = "John";
let age: number = 30;
let isActive: boolean = true;
let numbers: number[] = [1, 2, 3];
```

### Q102: Interfaces vs Types?
```typescript
interface User {
  id: number;
  name: string;
  email?: string;
}
type Point = { x: number; y: number; };
```

### Q103: Generics?
```typescript
function identity<T>(arg: T): T {
  return arg;
}
class DataStore<T> {
  private data: T[] = [];
  add(item: T): void { this.data.push(item); }
}
```

### Q104: Advanced Types?
```typescript
type Partial<T> = { [P in keyof T]?: T[P] };
type Readonly<T> = { readonly [P in keyof T]: T[P] };
type Pick<T, K extends keyof T> = { [P in K]: T[P] };
```

### Q105: Classes in TypeScript?
```typescript
class Animal {
  private name: string;
  protected age: number;
  public species: string;
  
  constructor(name: string) {
    this.name = name;
  }
}
```

### Q106-Q120: TypeScript Concepts
- Type assertions
- Decorators
- Namespaces
- Declaration files
- tsconfig.json
- Strict mode
- Type inference
- Index signatures
- Keyof operator
- Typeof operator
- Discriminated unions
- Template literal types
- Const assertions
- Satisfies operator
- TypeScript with frameworks

---

## React Questions

### Q121: What is React?
Component-based JavaScript library for building UIs. Features: Virtual DOM, JSX, Hooks, Unidirectional data flow.

### Q122: Functional vs Class Components?
```jsx
// Functional
function Welcome({ name }) {
  return <h1>Hello, {name}</h1>;
}

// Class
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

### Q123: React Hooks?
```jsx
useState, useEffect, useContext, useRef, useMemo, useCallback, useReducer

const [count, setCount] = useState(0);
useEffect(() => {
  document.title = `Count: ${count}`;
}, [count]);
```

### Q124: Component Lifecycle?
```jsx
useEffect(() => {
  // Mount
  return () => {
    // Unmount
  };
}, []); // Dependencies
```

### Q125: State Management?
```jsx
// Local state
const [state, setState] = useState(initial);

// Context API
const ThemeContext = React.createContext();

// useReducer
const [state, dispatch] = useReducer(reducer, initialState);
```

### Q126: Props & PropTypes?
```jsx
function UserCard({ name, age, email }) {
  return <div>{name} - {age}</div>;
}
UserCard.propTypes = {
  name: PropTypes.string.isRequired,
  age: PropTypes.number.isRequired
};
```

### Q127: Event Handling?
```jsx
const handleClick = (e) => {
  e.preventDefault();
  console.log('Clicked');
};
<button onClick={handleClick}>Click</button>
```

### Q128: Conditional Rendering?
```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
{user && <UserProfile user={user} />}
{items.map(item => <Item key={item.id} {...item} />)}
```

### Q129: Lists & Keys?
```jsx
{todos.map(todo => (
  <li key={todo.id}>{todo.text}</li>
))}
```

### Q130: Forms & Controlled Components?
```jsx
const [value, setValue] = useState('');
<input value={value} onChange={(e) => setValue(e.target.value)} />
```

### Q131: React Router?
```jsx
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
</Routes>
```

### Q132: Custom Hooks?
```jsx
function useLocalStorage(key, initialValue) {
  const [value, setValue] = useState(() => {
    return localStorage.getItem(key) || initialValue;
  });
  
  useEffect(() => {
    localStorage.setItem(key, value);
  }, [key, value]);
  
  return [value, setValue];
}
```

### Q133: Performance Optimization?
```jsx
React.memo, useMemo, useCallback, lazy loading, code splitting
const MemoizedComponent = React.memo(Component);
const memoizedValue = useMemo(() => computeExpensive(a, b), [a, b]);
```

### Q134: Error Boundaries?
```jsx
class ErrorBoundary extends React.Component {
  componentDidCatch(error, info) {
    console.error(error, info);
  }
  render() {
    return this.props.children;
  }
}
```

### Q135: Context API?
```jsx
const ThemeContext = React.createContext();
<ThemeContext.Provider value={theme}>
  <App />
</ThemeContext.Provider>
const theme = useContext(ThemeContext);
```

### Q136-Q160: React Concepts
- Virtual DOM
- Reconciliation
- Fiber architecture
- JSX
- Fragments
- Portals
- Refs & forwardRef
- Higher-Order Components
- Render props
- Suspense & lazy
- Concurrent mode
- Server-side rendering
- Static site generation
- Redux/MobX
- React Query
- Testing (Jest, RTL)
- Styled components
- CSS modules
- React Native
- Best practices
- Code splitting
- Lazy loading
- Memoization
- Accessibility
- SEO optimization

---

## Angular Questions

### Q161: What is Angular?
TypeScript-based framework for building web applications. Features: Two-way data binding, Dependency injection, RxJS, CLI.

### Q162: Angular Architecture?
```
Modules → Components → Services → Templates
```

### Q163: Components?
```typescript
@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent {
  name: string = 'John';
  
  greet() {
    console.log(`Hello, ${this.name}`);
  }
}
```

### Q164: Data Binding?
```html
<!-- Interpolation -->
<h1>{{ title }}</h1>

<!-- Property binding -->
<img [src]="imageUrl">

<!-- Event binding -->
<button (click)="handleClick()">Click</button>

<!-- Two-way binding -->
<input [(ngModel)]="name">
```

### Q165: Directives?
```html
<!-- Structural -->
<div *ngIf="isVisible">Content</div>
<div *ngFor="let item of items">{{ item }}</div>
<div [ngSwitch]="value">
  <div *ngSwitchCase="'A'">Case A</div>
</div>

<!-- Attribute -->
<div [ngClass]="{'active': isActive}"></div>
<div [ngStyle]="{'color': textColor}"></div>
```

### Q166: Services & DI?
```typescript
@Injectable({ providedIn: 'root' })
export class UserService {
  constructor(private http: HttpClient) {}
  
  getUsers() {
    return this.http.get('/api/users');
  }
}

// Inject in component
constructor(private userService: UserService) {}
```

### Q167: Lifecycle Hooks?
```typescript
ngOnInit() { }
ngOnChanges() { }
ngDoCheck() { }
ngAfterContentInit() { }
ngAfterContentChecked() { }
ngAfterViewInit() { }
ngAfterViewChecked() { }
ngOnDestroy() { }
```

### Q168: Routing?
```typescript
const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'users/:id', component: UserComponent },
  { path: '**', component: NotFoundComponent }
];

// Navigate
constructor(private router: Router) {}
this.router.navigate(['/users', userId]);
```

### Q169: Forms?
```typescript
// Template-driven
<form #form="ngForm" (ngSubmit)="onSubmit(form)">
  <input name="username" ngModel required>
</form>

// Reactive
this.form = this.fb.group({
  username: ['', Validators.required],
  email: ['', [Validators.required, Validators.email]]
});
```

### Q170: HTTP Client?
```typescript
this.http.get('/api/users').subscribe(
  data => console.log(data),
  error => console.error(error)
);
```

### Q171: RxJS Observables?
```typescript
import { Observable, of, from } from 'rxjs';
import { map, filter, catchError } from 'rxjs/operators';

this.users$ = this.http.get('/api/users').pipe(
  map(users => users.filter(u => u.active)),
  catchError(error => of([]))
);
```

### Q172: Pipes?
```html
{{ date | date:'short' }}
{{ price | currency:'USD' }}
{{ text | uppercase }}
{{ items | json }}

<!-- Custom pipe -->
{{ value | customPipe:arg1:arg2 }}
```

### Q173: Modules?
```typescript
@NgModule({
  declarations: [AppComponent, UserComponent],
  imports: [BrowserModule, FormsModule, HttpClientModule],
  providers: [UserService],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

### Q174: Lazy Loading?
```typescript
const routes: Routes = [
  {
    path: 'admin',
    loadChildren: () => import('./admin/admin.module').then(m => m.AdminModule)
  }
];
```

### Q175: Guards?
```typescript
@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(): boolean {
    return this.authService.isAuthenticated();
  }
}

{ path: 'admin', component: AdminComponent, canActivate: [AuthGuard] }
```

### Q176-Q200: Angular Concepts
- Change detection
- Zone.js
- ViewChild & ContentChild
- Template reference variables
- ng-content
- Custom directives
- Custom pipes
- Interceptors
- Resolvers
- State management (NgRx)
- Testing (Jasmine, Karma)
- Angular CLI
- AOT compilation
- Ivy renderer
- Standalone components
- Signals (Angular 16+)
- Server-side rendering
- Progressive Web Apps
- Internationalization
- Accessibility
- Performance optimization
- Best practices
- Migration strategies
- Angular Universal
- Angular Material

---

## Quick Reference

### HTML5 Elements
```
<header>, <nav>, <main>, <article>, <section>, <aside>, <footer>
<figure>, <figcaption>, <details>, <summary>, <mark>, <time>
```

### CSS Selectors
```css
element, .class, #id, [attribute], :pseudo-class, ::pseudo-element
```

### JavaScript ES6+
```javascript
let, const, arrow functions, template literals, destructuring,
spread/rest, classes, modules, promises, async/await
```

### TypeScript Types
```typescript
string, number, boolean, array, tuple, enum, any, unknown, void, never
```

### React Hooks
```javascript
useState, useEffect, useContext, useRef, useMemo, useCallback,
useReducer, useLayoutEffect, useImperativeHandle
```

### Angular Decorators
```typescript
@Component, @Directive, @Pipe, @Injectable, @NgModule,
@Input, @Output, @ViewChild, @ContentChild, @HostListener
```

---

## Interview Tips

### Technical Questions
- Explain concepts clearly
- Provide code examples
- Discuss trade-offs
- Mention best practices
- Show problem-solving skills

### Coding Challenges
- Understand requirements
- Think aloud
- Start simple, then optimize
- Test your code
- Handle edge cases

### System Design
- Ask clarifying questions
- Consider scalability
- Discuss performance
- Address security
- Plan for maintenance

---

**Total Questions: 200**
**Topics: HTML5, CSS3, JavaScript, ES6+, TypeScript, React, Angular**
**Comprehensive coverage for Full Stack Frontend Development**
