---
title: Contact Us
nav_exclude: true
---

# Contact Us

<!-- modify this form HTML and place wherever you want your form -->
<form
  action="https://opengolfsim.com/api/contact/support"
  method="POST"
>
  <div class="contact-form">
    <div class="contact-form-ele">
      <div>Your email</div>
      <div><input type="email" class="styled-input" name="email" /></div>
    </div>
    <div class="contact-form-ele">
      <div>Your message</div>
      <div><textarea name="message" class="styled-input" rows="10"></textarea></div>
    </div>
    <button class="button" type="submit">Send</button>
  </div>
  <input type="hidden" name="successUrl" value="https://help.opengolfsim.com/contact-thanks" />
</form>
