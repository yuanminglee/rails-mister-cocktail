import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#search-typed-text', {
    strings: ["Search for a cocktail", "Alcohol is life"],
    typeSpeed: 50,
    loop: true,
    bindInputFocusEvents: true,
    onStop: (arrayPos, self) => {
      console.log(self)
      self.el.value = ""
    }
  });
}

export { loadDynamicBannerText };
