# SwiftUI Drag and Drop Example
[![Swift](https://img.shields.io/badge/SwiftUI-green.svg)](https://swift.org)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-13.0-blue.svg)](https://developer.apple.com/xcode)

This example shows how to:
* Implement reorder items in `LazyVStack`. 
* Customize the SwiftUI `.onDrag`, `.onDrop`. 
* Solve issue when you select an item and release it (to cancel) and view is not reset.
* Solve issue when you drop an item outside the view and view is not reset.

### 📲 Hide selected view on drag
By default the selected item moves with drag preview. 
<p float="left">
<img src="https://user-images.githubusercontent.com/25620329/188598046-c5970fed-bbbc-4dfb-95c3-4f5c6c1efb08.gif" width="300"> 
<img src="https://user-images.githubusercontent.com/25620329/188598034-c9e7e316-e323-417f-bc4e-fecf6fd029ad.gif" width="300">
</p>

### 📏 Preview with same shape as item view.
<p float="left">
<img src="https://user-images.githubusercontent.com/25620329/188603908-a62203de-4ff5-429d-bd98-33b7c4a6340e.jpg" width="300">
<img src="https://user-images.githubusercontent.com/25620329/188603904-5b43f025-aad8-4ed9-ad79-e3f799ef6ab4.jpg" width="300"> 
</p>

```
.contentShape([.dragPreview],CornerShape(radius: 12, corners: [.topRight, .bottomRight]))
```

### 🪲 Solve issue when you pick an item and release it (to cancel) and view is not reset.
Since `performDrop` will not be called and we handle it mannualy.
<p float="left">
<img src="https://user-images.githubusercontent.com/25620329/188602669-012117b7-ab13-43e5-826e-b69abd54e0dd.gif" width="300">
<img src="https://user-images.githubusercontent.com/25620329/188602664-0b573300-151e-454e-bb9d-5a0279cb670b.gif" width="300"> 
</p>

### 🪲 Solve issue when you drop an item outside the view and view is not reset.
Since `performDrop` will not be called and we handle it mannualy.
<p float="left">
<img src="https://user-images.githubusercontent.com/25620329/188603203-94e9d34a-66b7-4e0e-b72f-2e20ab82b295.gif" width="300">
<img src="https://user-images.githubusercontent.com/25620329/188603209-89ba443e-8f82-4c46-909b-d20740c4fed9.gif" width="300"> 
</p>

### 🧾 Summary
We still see some challenges and limitations that face you when using SwiftUI. We propose some workarounds to improve functionality if you are using `.onDrag`, `.onDrop` for reordering elements. 

### 🦍 Author
[Nazar Kvyatkovsky](https://www.instagram.com/nazarkvyatkovsky) 
Mobile Team Leader and iOS Developer at [Tapforce](https://www.instagram.com/tapforceteam)
