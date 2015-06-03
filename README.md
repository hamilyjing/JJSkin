# JJSkin

JJSkin makes it easy to write a interface control property. You do not care if the current control property is used on iPhone or ipad or differnt screen sizes. JJSkin will help you.

# Problem

* We write control property codes for iPhone and iPad.
* We write control property codes for different screen sizes on iPhone or iPad.
* We write control property hard codes that make it hard to change the interface skin. For example, we need a new skin for Spring Festival.

JJSkin solves those problems.

# Usage

* First write skin config files with json format.

```objc
{
    "portrait": {
        "stringValue": "1234567890",
        "intergerValue": "890",
        "floatValue": "234.9",
        "boolValue": "1",
        "edgeInsets": "{1,2,3,4}",
        "rect": "{{5,6},{7,8}}",
        "size": "{9,0}",
        "color": "#FFc58dd0",

        "textLabel": {
            "text": "portrait",
            "textAlignment": "right",
            "lineBreakMode": "clipping"
        }
    },
    "landscape": {
        "textLabel": {
        "text": "landscape",
        "textAlignment": "center",
        }
    }
}
```

* Second pull JJSkin/JJSkin to your project and import "JJSkin.h".

* Third get or update object property.

```objc
/**
    ID is json label path linked by dot.
    ID begins "R" and exclude root label, "portrait" and "landscape".
*/
NSString *stringValue = [JJSkinManager getStringByID:@"R.stringValue"];
CGFloat floatValue = [JJSkinManager getFloatByID:@"R.floatValue"];
CGRect rect = [JJSkinManager getRectByID:@"R.rect"];

/** 
    Create UILabel object.
    In portrait screen, label text is "portrait", and text Alignment is right.
    In landscapt screen, label text is "landscape", and text Alignment is center.
*/
UILabel *label = [JJSkinManager getLabelByID:@"R.textLabel"];

/** 
    Update existed UILable object.
    label1 has the same property with label.
*/
UILabel *label1 = [[UILabel alloc] init];
[JJSkinManager updateLabel:label1 withID:@"R.textLabel"];
```

# Skin style class

* Skin style class defines interface control's properties. Those propetry names will be used in config files.

```objc
@interface JJLabelStyle : JJViewStyle

@property (nonatomic, strong) JJFontStyle *fontStyle;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, copy) NSString *textAlignment;
@property (nonatomic, copy) NSString *lineBreakMode;

@property (nonatomic, copy) NSString *numberOfLines;

@property (nonatomic, strong) UIColor *highlightedTextColor;

@end
```

* Config file

```objc
"textLabel": {
"text": "portrait", // Must same with JJLabelStyle text property name
"textAlignment": "right",
"lineBreakMode": "clipping"
}
```

* You can define your style to inherite JJSkinStyle class and use JJSkinManager class API to get or update object. The propety attritube of your defined style class must inherite NSObject, otherwise you will write analyse type conversion codes.
```objc
+ (id)getObjectByID:(NSString *)id withStyleClass:(Class)styleClass;
+ (void)updateObject:(id)object withID:(NSString *)id withStyleClass:(Class)styleClass;
```

# Skin config

JJSkin will analyse style values from first file, When you invoke JJSkinManager API to get object. If JJSkin does not get all style propeties, it will analyse the next file.

In one file, it has portrait and landscape root lable. If interface oritation is portrait, JJSkin only analyse portrait root label. If interface oritation is landscape, JJSkin will first analyse landscape root label. It will continue analyse portrait root label if JJSkin does not get all style values.

Be carefule, JJSkin will not continue to analyse if it has "status" label and its value is "finish". if the value is "finishIncludeSon", JJSkin will not analyse the son style value.

# License

JJSkin is released under the MIT license. See
[LICENSE](https://github.com/hamilyjing/JJSkin/blob/master/LICENSE).

# More Info

Have a question? Please [open an issue](https://github.com/hamilyjing/JJSkin/issues/new)!
