# Justification – Atomic Design Refactor

## Atoms

**SectionHeading** – Placed as an Atom because it is a `StatelessWidget` that renders one string with a fixed text style and holds no state or logic beyond what it needs to display that text. It's reused unmodified for "Search Products," "Catalog," and "Add New Product," which is exactly the kind of small, repeated primitive Atoms exist for.

**AppTextInput** – An Atom because it owns no state of its own: the controller, validator, and `onChanged` callback are always supplied by the caller. Accepting a validator *function* as a parameter is wiring, not logic – the widget never decides what's valid, it only forwards whatever rule it's given.

**AppDropdownField** – Same reasoning as `AppTextInput`: it is a pure rendering wrapper around `DropdownButtonFormField`. The options list, the selected value, and the change handler are all owned elsewhere, so the widget itself carries no business rules.

**PriceTag** – An Atom because formatting a `double` into a "PHP 599.00" string is a display concern, not business logic. It takes one price in and renders one string out, with no state.

**ProductIconAvatar** – An Atom: a fixed-size, fixed-style container around an icon. It has no state and makes no decisions – it just renders whatever `IconData` it's handed.

**CategoryLabel** – An Atom for the same reason as `PriceTag`: it's a one-line, stateless text renderer with a fixed style.

**PrimaryButton** – An Atom because it is the app's single reusable button style (indigo fill, white text), used identically for "Add to Cart" and "Submit Product." It holds no state and contains no business logic – `onPressed` is always someone else's callback.

**DeleteIconButton** – An Atom for the same reason as `PrimaryButton`: a small, stateless, style-fixed wrapper around `IconButton` that only forwards a tap.

## Molecules

**SearchField** – A Molecule because it combines two Atoms (`SectionHeading` + `AppTextInput`) into one reusable unit with a single purpose (searching). It holds no business data itself – the query string still lives on the Page – so it stays below the Organism boundary.

**ProductInfo** – A Molecule: it combines the name `Text`, `CategoryLabel`, and `PriceTag` Atoms into the "identity" block of a product card. It has a clear, narrow purpose (show what a product *is*) without owning any interaction logic.

**ProductActions** – A Molecule combining the `PrimaryButton` and `DeleteIconButton` Atoms into the action cluster of a card. It holds no local UI state and no business logic – "what happens" on add-to-cart or delete is entirely the caller's decision, forwarded through callbacks.

## Organisms

**ProductCard** – An Organism because it's a complete, meaningful section of UI: it lays out the `ProductIconAvatar` Atom together with the `ProductInfo` and `ProductActions` Molecules, plus its own card decoration (background, border, shadow). It knows about one `Product`, but per the rules it does not own the catalog's data – the list itself always lives on the Page.

**ProductCatalogList** – An Organism because it assembles the `SectionHeading` Atom with a list of `ProductCard` Organisms into the full catalog section. It receives an already-filtered list from the Page and never touches the master list, so it doesn't own core data even though it's a large, composed piece of UI.

**ProductForm** – An Organism because it contains real local logic: the `GlobalKey<FormState>`, the text controllers, the selected category, and the per-field validators. That state is the *ephemeral draft* of one new product, not the app's core data (the catalog), so an Organism is allowed to own it under the "organisms may contain local logic but should not own core data" rule. It composes the `SectionHeading`, `AppTextInput`, `AppDropdownField`, and `PrimaryButton` Atoms.

## Template

**CatalogPageTemplate** – A Template because it only defines the `Scaffold`/`AppBar`/`SingleChildScrollView` layout and three layout "slots" (`searchSection`, `catalogSection`, `formSection`) passed in as `Widget`s. It never imports `Product` or any other data model – it has no idea what kind of content it's arranging, which is the defining rule for this layer.

## Page

**CatalogPage** – The Page because it is the only widget in the app that holds the real `_products` list, the `_searchQuery`, and `_nextId`, and wires real data downward into `SearchField`, `ProductCatalogList`, and `ProductForm` through the `CatalogPageTemplate`. All add/delete/submit callbacks that actually mutate the catalog are defined here, matching the rule that Pages are the only layer allowed to own the app's core data.