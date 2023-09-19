import Foundation
import CosmosKit

class ThemeBuilder {

    enum BDSystemFonts: String, CosmosFontEnum {

        case helveticaNeueBold = "HelveticaNeue-Bold"
        case helveticaNeue = "HelveticaNeue"
        case helveticaNeueMedium = "HelveticaNeue-Medium"

        var name: String { rawValue }
        var fileType: FontFileType { .ttf }
    }

    enum BDFonts: String, CaseIterable, CosmosFontEnum {

        case latoRegular = "Lato-Regular"
        case latoBold = "Lato-Bold"
        case latoItalic = "Lato-Italic"
        case barlowBold = "Barlow-Bold"
        case montserratRegular = "Montserrat-Regular"
        case montserratBold = "Montserrat-Bold"
        case montserratItalic = "Montserrat-Italic"
        case merriweatherItalic = "Merriweather-Italic"
        case playfairDisplayBold = "PlayfairDisplay-Bold"
        case loraRegular = "Lora-Medium"
        case loraBold = "Lora-Bold"
        case loraItalic = "Lora-MediumItalic"
        case loraBoldItalic = "Lora-BoldItalic"
        case cheltenhamHeadlineBold = "CheltenhamBT-BoldHeadline"
        case cheltenhamStdBook = "CheltenhamStd-Book"

        var name: String {
            rawValue
        }

        var fileType: FontFileType {
            switch self {
            case .merriweatherItalic, .barlowBold, .cheltenhamHeadlineBold, .cheltenhamStdBook:
                return .otf
            default: return .ttf
            }
        }
    }

    static func importFonts() {
        for font in BDFonts.allCases {
            if Theme.registerFont(from: font.filename) {
                print("Font imported: \(font.rawValue)")
                if UIFont(name: font.rawValue, size: 10) != nil {
                    print("Successfully instantiated font: \(font.rawValue)")
                } else {
                    fatalError("failed to instantiate font: \(font.rawValue)")
                }
            } else {
                fatalError("failed to import font: \(font.rawValue)")
            }
        }
    }

    private var theme: Theme!

    // swiftlint:disable:next function_body_length
    func build(_ publication: Publications) -> ThemeBuilder {
        let articleTheme = ArticleTheme(dateFormat: "dd MMMM YYYY - HH:mm",
                                        footerDividerColor: UIColor(dynamic: .divider),
                                        bodyFontName: BDFonts.loraRegular.rawValue,
                                        bodyItalicFontName: BDFonts.loraItalic.rawValue,
                                        bodyBoldFontName: BDFonts.loraBold.rawValue)

        let articleHeaderTheme = ArticleHeaderTheme(coBrandHeight: 15,
                                                    dateColor: UIColor(grayScale: .gray4),
                                                    dateFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                                    titleColor: UIColor(dynamic: .text),
                                                    titleFont: UIFont(name: BDFonts.cheltenhamHeadlineBold, textStyle: .title2),
                                                    underTitleColor: UIColor(dynamic: .text),
                                                    underTitleFont: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                                    overTitleColor: UIColor(dynamic: .text),
                                                    overTitleFont: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                                    sectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                                    sectionColor: UIColor(dynamic: .text),
                                                    introFont: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                                    headerBylineFont: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                                    headerByline2Font: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                                    headerBylineColor: UIColor(dynamic: .text))

        let quoteTheme = QuoteTheme(backgroundColor: UIColor(dynamic: .background),
                                    quoteColor: UIColor(dynamic: .text),
                                    quoteFont: UIFont(name: BDFonts.montserratBold, textStyle: .body),
                                    authorColor: UIColor(dynamic: .text),
                                    authorFont: UIFont(name: BDFonts.montserratItalic, textStyle: .footnote),
                                    topLineColor: UIColor(dynamic: .quoteDivider),
                                    bottomLineColor: UIColor(dynamic: .quoteDivider))

        let authorTheme = AuthorTheme(nameFont: UIFont(name: BDFonts.montserratRegular, textStyle: .footnote),
                                      nameColor: UIColor(grayScale: .gray4),
                                      categoryFont: UIFont(name: BDFonts.montserratRegular, textStyle: .footnote),
                                      categoryColor: UIColor(grayScale: .gray4))

        let relatedArticleTheme = RelatedArticleTheme(backgroundColor: UIColor(dynamic: .brandSecondary),
                                                      titleColor: UIColor(grayScale: .gray1),
                                                      titleFont: UIFont(name: BDFonts.cheltenhamHeadlineBold, textStyle: .body),
                                                      sectionColor: UIColor(grayScale: .gray1),
                                                      sectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .caption1),
                                                      authorColor: UIColor(grayScale: .gray1),
                                                      authorFont: UIFont(name: BDFonts.montserratRegular, textStyle: .footnote),
                                                      readTimeColor: UIColor(grayScale: .gray4),
                                                      readTimeFont: UIFont(name: BDFonts.merriweatherItalic, textStyle: .footnote),
                                                      dateColor: UIColor(grayScale: .gray4),
                                                      dateFont: UIFont(name: BDFonts.merriweatherItalic, textStyle: .footnote),
                                                      summaryColor: UIColor(grayScale: .gray2),
                                                      summaryFont: UIFont(name: BDFonts.loraRegular, textStyle: .subheadline),
                                                      dividerColor: UIColor(dynamic: .divider))

        let articleListTheme = ArticleListTheme(featuredTitleColor: UIColor(dynamic: .text),
                                                featuredTitleFont: UIFont(name: BDFonts.cheltenhamHeadlineBold, textStyle: .title3),
                                                featuredSectionColor: UIColor(dynamic: .text),
                                                featuredSectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                                titleColor: UIColor(dynamic: .text),
                                                titleFont: UIFont(name: BDFonts.cheltenhamHeadlineBold, textStyle: .headline),
                                                sectionColor: UIColor(dynamic: .text),
                                                sectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                                videoIcon: UIImage(),
                                                useCellSeparators: true,
                                                gradientColor: UIColor(dynamic: .imageGradient))

        let sectionsTheme = SectionsTheme(sectionFont: UIFont(name: BDFonts.montserratBold, textStyle: .subheadline),
                                          sectionColor: UIColor(dynamic: .text),
                                          subSectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .caption1),
                                          subSectionColor: UIColor(dynamic: .text),
                                          specialReportFont: UIFont(name: BDFonts.montserratRegular, textStyle: .caption1),
                                          specialReportColor: .white)

        let viewHeaderTheme = ViewHeaderTheme(style: .compressed,
                                              titleColor: .white,
                                              titleFont: UIFont(name: BDFonts.montserratBold, textStyle: .body),
                                              backgroundColor: UIColor(dynamic: .brandPrimary))

        let searchTheme = SearchTheme(textColor: UIColor(grayScale: .white),
                                      cursorColor: UIColor(dynamic: .brandPrimary))

        let settingsTheme = SettingsTheme(titleFont: UIFont(name: BDSystemFonts.helveticaNeue, textStyle: .subheadline),
                                          titleColor: UIColor(dynamic: .text),
                                          settingFont: UIFont(name: BDSystemFonts.helveticaNeue, textStyle: .body),
                                          settingColor: UIColor(dynamic: .text),
                                          fontLabelFont: UIFont(name: BDFonts.loraBold, textStyle: .body),
                                          fontIndicatorFont: BDFonts.loraBold.rawValue)

        let legacyAuthTheme = LegacyAuthorizationTheme(mainButtonFont: UIFont(name: BDFonts.montserratBold, textStyle: .body),
                                                 mainButtonColor: UIColor(grayScale: .white),
                                                 secondaryButtonFont: UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .footnote),
                                                 textFont: UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .footnote),
                                                 textColor: UIColor(dynamic: .text),
                                                 italicTextFont: UIFont(name: BDFonts.montserratItalic.rawValue, textStyle: .footnote),
                                                 italicTextColor: UIColor(dynamic: .text),
                                                 termsAndConditionsFont: UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .footnote),
                                                 termsAndConditionsTintFont: UIFont(name: BDFonts.montserratBold.rawValue, textStyle: .footnote),
                                                 termsAndConditionsColor: UIColor(grayScale: .gray4),
                                                 backgroundColor: UIColor(dynamic: .background),
                                                 logo: UIImage(bdName: .logoDynamic))

        let navigationTheme = NavigationTheme(color: UIColor(grayScale: .gray1),
                                              buttonColor: .white,
                                              buttonTextColor: .white,
                                              progressBarColor: .clear)

        let fallbackTheme = FallbackTheme(titleColor: UIColor(dynamic: .text),
                                          titleFont: UIFont(name: BDSystemFonts.helveticaNeue, textStyle: .body),
                                          bodyColor: UIColor(dynamic: .text),
                                          bodyFont: UIFont(name: BDSystemFonts.helveticaNeue, textStyle: .body))

        let videosTheme = VideosTheme(backgroundColor: UIColor(dynamic: .background),
                                      titleColor: UIColor(dynamic: .text),
                                      titleFont: UIFont(name: BDFonts.cheltenhamHeadlineBold, textStyle: .headline),
                                      sectionColor: UIColor(dynamic: .text),
                                      shouldShowSectionBlock: true,
                                      sectionFont: UIFont(name: BDFonts.montserratRegular, textStyle: .caption1),
                                      publishedTimeColor: UIColor(grayScale: .gray4),
                                      publishedTimeFont: UIFont(name: BDFonts.merriweatherItalic, textStyle: .caption2))

        let authTheme = AuthorizationTheme(primaryButtonFont: UIFont(name: BDFonts.montserratBold, textStyle: .body),
                                           primaryButtonColor: UIColor(grayScale: .white),
                                           secondaryButtonFont: UIFont(name: BDFonts.montserratBold, textStyle: .subheadline),
                                           secondaryButtonColor: UIColor(dynamic: .secondaryButton),
                                           headingFont: UIFont(name: BDSystemFonts.helveticaNeueBold, textStyle: .title1),
                                           headingColor: UIColor(dynamic: .text),
                                           textFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                           textColor: UIColor(dynamic: .text),
                                           textFieldDescriptorFont: UIFont(name: BDFonts.montserratBold, textStyle: .subheadline),
                                           textFieldDescriptorColor: UIColor(dynamic: .text),
                                           textFieldFont: UIFont(name: BDFonts.montserratRegular, textStyle: .body),
                                           textFieldColor: UIColor(dynamic: .text),
                                           textFieldBackgroundColor: UIColor(dynamic: .headerDivider),
                                           termsAndConditionsFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                           termsAndConditionsTintFont: UIFont(name: BDFonts.montserratRegular, textStyle: .subheadline),
                                           termsAndConditionsColor: UIColor(dynamic: .text),
                                           termsAndConditionsActive: UIImage(),
                                           termsAndConditionsInactive: UIImage(),
                                           newsletterFont: UIFont(name: BDFonts.montserratBold, textStyle: .subheadline),
                                           newsletterColor: UIColor(dynamic: .text),
                                           newsletterActiveTint: UIColor(dynamic: .brandPrimary),
                                           newsletterInactiveTint: UIColor(dynamic: .switchInactive),
                                           newsletterSwitchBackground: UIColor(dynamic: .switchBackground),
                                           newsletterSwitchBorder: UIColor(dynamic: .switchBorder),
                                           backgroundColor: UIColor(dynamic: .background),
                                           logo: UIImage(bdName: .logoDynamic))

        self.theme =  Theme(textColor: UIColor(dynamic: .text),
                            separatorColor: UIColor(dynamic: .divider),
                            backgroundColor: UIColor(dynamic: .background),
                            accentColor: UIColor(dynamic: .brandPrimary),
                            logo: UIImage(bdName: .logoWhite),
                            articleTheme: articleTheme,
                            articleHeaderTheme: articleHeaderTheme,
                            quoteTheme: quoteTheme,
                            authorTheme: authorTheme,
                            relatedArticleTheme: relatedArticleTheme,
                            articleListTheme: articleListTheme,
                            sectionsTheme: sectionsTheme,
                            viewHeaderTheme: viewHeaderTheme,
                            searchTheme: searchTheme,
                            settingsTheme: settingsTheme,
                            authTheme: authTheme,
                            legacyAuthTheme: legacyAuthTheme,
                            navigationTheme: navigationTheme,
                            fallbackTheme: fallbackTheme,
                            videosTheme: videosTheme)
        return self
    }

    func applyLocalTheme() -> Theme {
        applyAppColors()
        applyAppFonts()
        return self.getTheme()
    }

    func getTheme() -> Theme {
        return self.theme
    }

    private func applyAppFonts() {
        applyCellFonts()
        applyMarketFonts()
        applyArticleHeaderFonts()
    }

    func applyCellFonts() {
        BDSectionLabel.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .footnote)
        BDTitleLabel.appearance().font = UIFont(name: BDFonts.cheltenhamHeadlineBold.rawValue, textStyle: .title3)
        BDFeaturedTitleLabel.appearance().font = UIFont(name: BDFonts.cheltenhamHeadlineBold.rawValue, textStyle: .title2)
        BDSynopsisLabel.appearance().font = UIFont(name: BDFonts.loraRegular.rawValue, textStyle: .subheadline)
        BDTimeLabel.appearance().font = UIFont(name: BDFonts.merriweatherItalic.rawValue, textStyle: .caption2)
        BDRelatedSectionLabel.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .caption1)
        BDRelatedTitleLabel.appearance().font = UIFont(name: BDFonts.cheltenhamHeadlineBold.rawValue, textStyle: .callout)
        BDRelatedSynopsisLabel.appearance().font = UIFont(name: BDFonts.loraRegular.rawValue, textStyle: .subheadline)
    }

    func applyMarketFonts() {
        TabLabel.appearance().font = UIFont(name: BDFonts.montserratBold.rawValue, textStyle: .subheadline)
    }

    func applyArticleHeaderFonts() {
        BDArticleSectionLabel.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .subheadline)
        BDArticleTitleLabel.appearance().font = UIFont(name: BDFonts.cheltenhamStdBook.rawValue, textStyle: .largeTitle)
        BDArticleOverTitleLabel.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .subheadline)
        BDArticleUnderTitleLabel.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .subheadline)
        BDArticleMetaInfoLabel.appearance().font = UIFont(name: BDFonts.montserratBold.rawValue, textStyle: .caption1)
        BDArticleUpdatedTimeLabel.appearance().font = UIFont(name: BDFonts.montserratBold.rawValue, textStyle: .caption1)
        BDArticleAuthorInfoLabel.appearance().font = UIFont(name: BDFonts.montserratBold.rawValue, textStyle: .footnote)

        BDBlockerLabelLengthy.appearance().font = UIFont(name: BDFonts.loraRegular.rawValue, textStyle: .subheadline)
        BDBlockerLabelShort.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .subheadline)
        BDBlockerTextView.appearance().font = UIFont(name: BDFonts.montserratRegular.rawValue, textStyle: .subheadline)
    }

    fileprivate func applyAppColors() {
        applyCellColors()
        applyMarketColors()
        applyArticleHeaderColors()
        applyNavColors()
    }

    fileprivate func applyCellColors() {
        SectionBlock.appearance().backgroundColor = UIColor(dynamic: .brandPrimary)
        BDSectionLabel.appearance().textColor = UIColor(dynamic: .text)
        BDTitleLabel.appearance().textColor = UIColor(dynamic: .text)
        BDFeaturedTitleLabel.appearance().textColor = UIColor(dynamic: .text)
        BDSynopsisLabel.appearance().textColor = UIColor(dynamic: .text)
        BDTimeLabel.appearance().textColor = UIColor(grayScale: .gray4)
        BDRelatedSectionLabel.appearance().textColor = UIColor(grayScale: .gray1)
        BDRelatedTitleLabel.appearance().textColor = UIColor(grayScale: .gray1)
        BDRelatedSynopsisLabel.appearance().textColor = UIColor(grayScale: .gray1)
    }

    fileprivate func applyMarketColors() {
        TabLabel.appearance().textColor = UIColor(dynamic: .text)
    }

    fileprivate func applyArticleHeaderColors() {
        BDArticleSectionLabel.appearance().textColor = UIColor(dynamic: .text)
        BDArticleTitleLabel.appearance().textColor = UIColor(dynamic: .text)
        BDArticleOverTitleLabel.appearance().textColor = UIColor(dynamic: .text)
        BDArticleUnderTitleLabel.appearance().textColor = UIColor(dynamic: .text)
        BDArticleMetaInfoLabel.appearance().textColor = UIColor(grayScale: .gray4)
        BDArticleUpdatedTimeLabel.appearance().textColor = UIColor(dynamic: .brandPrimary)
        BDArticleDivider.appearance().backgroundColor = UIColor(dynamic: .headerDivider)
        BDArticleAuthorInfoLabel.appearance().textColor = UIColor(dynamic: .text)

        BDBlockerLabelLengthy.appearance().textColor = UIColor(dynamic: .text)
        BDBlockerLabelShort.appearance().textColor = UIColor(dynamic: .text)
        BDBlockerTextView.appearance().textColor = UIColor(dynamic: .text)
        BDBlockerTextView.appearance().backgroundColor = .clear
        BDBlockerTextView.appearance().tintColor = UIColor(dynamic: .brandPrimary)
        BDBlockerButton.appearance().tintColor = UIColor(grayScale: .white)
    }

    fileprivate func applyNavColors() {
        let navUnselected = UIColor(grayScale: .gray4)
        let navSelected = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: navUnselected], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: navSelected], for: .selected)
        UITabBar.appearance().tintColor = navSelected
        UITabBar.appearance().unselectedItemTintColor = navUnselected
        UITabBar.appearance().barTintColor = theme.navigationTheme.color
    }
}
