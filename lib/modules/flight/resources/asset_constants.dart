import 'dart:math';

class AssetConstants {
  static const imagesPath = 'assets/images/';
  static const iconsPath = 'assets/icons/flags/png/';

  static const hello = '${imagesPath}hello.png';
  static const logoBlue = '${imagesPath}logoBlue.png';
  static const profileLogoBlue = '${imagesPath}profileLogoBlue.png';
  static const logoWhite = '${imagesPath}logoWhite.png';
  static const greenTick = '${imagesPath}greenTick.png';
  static const personSelected = '${imagesPath}personSelected.png';
  static const personUnSelected = '${imagesPath}personUnSelected.png';
  static const merchantSelected = '${imagesPath}merchantSelected.png';
  static const merchantUnSelected = '${imagesPath}merchantUnSelected.png';
  static const category = '${imagesPath}category.png';
  static const tickMark = '${imagesPath}tickMark.png';
  static const drawerBack = '${imagesPath}drawer_back.png';
  static const logout = '${imagesPath}logout.png';
  static const camera = '${imagesPath}camera.png';
  static const edit = '${imagesPath}edit.png';
  static const qrIcon = '${imagesPath}qr_icon.png';
  static const qrBorder = '${imagesPath}qr_border.png';
  static const security = '${imagesPath}security.png';
  static const feesAndLimits = '${imagesPath}fees_and_limits.png';
  static const gpsActivation = '${imagesPath}gps_activation.png';
  static const privacyPolicy = '${imagesPath}privacy_policy.png';
  static const support = '${imagesPath}support.png';
  static const termsAndConditions = '${imagesPath}terms_and_condition.png';
  static const language = '${imagesPath}language.png';
  static const lock = '${imagesPath}lock.png';
  static const pin = '${imagesPath}pin.png';
  static const gender = '${imagesPath}gender.png';
  static const birthdayCake = '${imagesPath}birthday_cake.png';
  static const calendar = '${imagesPath}calendar.png';
  static const person = '${imagesPath}person.png';
  static const merchant = '${imagesPath}merchant.png';
  static const merchantType = '${imagesPath}merchant_type.png';
  static const icCopy = '${imagesPath}copy.png';
  static const icSenderAddress = '${imagesPath}ic_address.png';
  static const icInfo = '${imagesPath}ic_info.png';
  static const icDepositMethod = '${imagesPath}ic_deposit_method.png';
  static const icDepositHistory = '${imagesPath}ic_deposit_history.png';
  static const icChooseNetwork = '${imagesPath}ic_choose_network.png';
  static const icPortfolio = '${imagesPath}ic_portfolio.png';
  // static const icSelected = '${imagesPath}ic_selected.png';
  static const icShare = '${imagesPath}ic_share.png';
  static const icPending = '${imagesPath}ic_pending.png';
  static const icIdNumber = '${imagesPath}ic_id_number.png';
  static const icUser = '${imagesPath}ic_user.png';
  static const icBankAccountsWb = '${imagesPath}ic_bank_acc_wb.png';
  static const icReceiverWallet = '${imagesPath}ic_receiver_wallet.png';
  static const messagexxxhdpi = '${imagesPath}message-xxxhdpi.png';
  static const searchxxxhdpi = '${imagesPath}search-xxxhdpi.png';
  static const lockxxxhdpi = '${imagesPath}lock-xxxhdpi.png';
  static const flagxxxhdpi = '${imagesPath}flag-xxxhdpi.png';
  static const userxxxhdpi = '${imagesPath}user-xxxhdpi.png';
  static const phonexxxhdpi = '${imagesPath}phone-xxxhdpi.png';
  static const favouritexxxhdpi = '${imagesPath}favourite-xxxhdpi.png';
  static const favouriteUnselected = '${imagesPath}favourite_unselected.png';
  static const home = '${imagesPath}home.png';
  static const city = '${imagesPath}smart-city.png';
  static const street = '${imagesPath}building.png';
  static const state = '${imagesPath}usa-map.png';
  static const zipCode = '${imagesPath}zip-code.png';
  static const relationPurpose = '${imagesPath}submitted.png';

  static const flagIcons = '${iconsPath}xx.png';
  static const common = '${imagesPath}xx.png';
  static const kycPendingIcon = '${imagesPath}kycPendingDailogIcon.png';
  static const acceptDeclineIcon = '${imagesPath}approve_decline.png';
  static const conversionIcon = '${imagesPath}conversion_icon.png';
  static const transactionHistory = '${imagesPath}transaction-history.png';

  static const investment = '${imagesPath}dashboard/investment.svg';
  static const mall = '${imagesPath}dashboard/mall.svg';
  static const more = '${imagesPath}dashboard/more.svg';
  static const remittance1 = '${imagesPath}globe.png';

  static const goldIngots = '${imagesPath}orocash/gold-bar.svg';
  static const jewelry = '${imagesPath}orocash/icon-jewel.svg';
  static const branches = '${imagesPath}orocash/icon-store.svg';
  static const commingSoon = '${imagesPath}orocash/icon-comingsoon.svg';
  static const oroCash = '${imagesPath}orocash/icon-orocash.svg';

  static const imagesProfilePath = 'assets/images/profile/';
  static String getRandomProfile() {
    Random random = Random();
    int randomNumber = random.nextInt(6);
    String imagePath = "${imagesProfilePath}profile${randomNumber + 1}.jpg";
    return imagePath;
  }

  static String getCoinIcon(String symbol) {
    switch (symbol) {
      case 'BTC':
        return '${imagesPath}btc_icon.png';
      case 'USDC':
        return '${imagesPath}usdc_icon.png';
      default:
        return '${imagesPath}btc_icon.png';
    }
  }

  static String lottieClock = 'assets/lottie/clock.json';
}
