<template>
  <footer>
    <section class="bio flex centered">
      <div class="column">
        <div class="larger logo bolder icon header">
          <img src="@/assets/logo.png" alt="logo"><span class="green text">GREENSHOP</span>
        </div>
      </div>
      <div class="column">
        <div class="flex relaxed centered">
          <i class="larger green icofont icofont-google-map icon"></i>
          <div class="text">
            <p>Nowhere, Null Ave</p>
            <p>Empty, N/A 00000</p>
          </div>
        </div>
      </div>
      <div class="column">
        <div class="flex relaxed centered">
          <i class="larger green icofont icofont-envelope icon"></i>
          <span class="text">sample@gmail.com</span>
        </div>
      </div>
      <div class="column">
        <div class="flex relaxed centered">
          <i class="larger green icofont icofont-phone icon"></i>
          <div class="text">
            <p>8 029 000 11 22</p>
            <p>8 044 333 44 55</p>
          </div>
        </div>
      </div>
    </section>
    <section class="info">
      <div class="column">
        <div class="menu vertical">
          <div class="header">About us</div>
          <div class="link item">Our stores</div>
          <div class="link item">Career</div>
          <div class="link item">Specials</div>
        </div>
      </div>
      <div class="column">
        <div class="menu vertical">
          <div class="header">Help &amp; Guide</div>
          <div class="link item">Help center</div>
          <div class="link item">How To Buy</div>
          <div class="link item">Shipping &amp; Delivery</div>
          <div class="link item">Product Policy</div>
          <div class="link item">How To Return</div>
        </div>
      </div>
      <div class="column">
        <div class="menu vertical">
          <div class="header">Social Media</div>
          <div class="item">
            <div class="flex relaxed">
              <div class="small basic icon green button">
                <i class="icofont icofont-facebook"></i>
              </div>
              <div class="small basic icon green button">
                <i class="icofont icofont-instagram"></i>
              </div>
              <div class="small basic icon green button">
                <i class="icofont icofont-twitter"></i>
              </div>
              <div class="small basic icon green button">
                <i class="icofont icofont-linkedin"></i>
              </div>
              <div class="small basic icon green button">
                <i class="icofont icofont-youtube-play"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="menu vertical">
          <div class="header">We accept</div>
          <div class="item">
            <img src="@/assets/payment.png" alt="payment">
          </div>
        </div>
      </div>
      <div class="column">
        <div class="menu vertical">
          <div class="header">Woud you like to join newsletters?</div>
          <div class="item">
            <div class="action input">
              <input type="text" placeholder="email address..." />
              <div class="green button">Join</div>
            </div>
          </div>
          <div class="item">
            <span class="small secondary text">We usually post offers and challenges in newsletter. We’re your online houseplant destination. We offer a wide range of houseplants and accessories shipped directly from our (<span class="green text">green</span>) house to yours! </span>
          </div>
        </div>
      </div>
    </section>
    <section class="justify-center copyrights">
      PlantsStore, © 2023 SharSchnitzel Inc. Wish I have all the Rights Reserved. :(
    </section>
  </footer>
</template>

<script>

export default {
  name: 'store-footer',
}

</script>

<style scoped lang="scss">
  footer {
    margin-top: 2rem;
    >.copyrights {
      font-size: .9em;
      padding: .7em;
      border-top: 1px solid var(--color-border-secondary);
    }
  }
  section {
    display: flex;
    >.column {
      width: 22%;
      &:last-child {
        width: 34%;
      }
    }
    &.bio {
      padding: 1em 2em;
      background: rgba(70, 163, 88, 0.1);
      border: 1px solid var(--color-border-main);
      border-left: none;
      border-right: none;
    }

    &.info {
      padding: 1em 2em;
      background-color: var(--color-lightgrey);
    }

    .menu {
      >.link.item {
        &:hover {
          color: var(--color-green);
        }
      }
      +.menu {
        margin-top: 1rem;
      }
    }
  }
</style>
