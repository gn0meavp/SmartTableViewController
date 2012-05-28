//
//  FlexibleEditTableViewCell.h
//
//  Created by Alexey Patosin on 12/12/11.
//

#import "EditTableViewCell.h"

typedef BOOL(^ShouldChangeCharactersInRange)(NSRange range, NSString *string);
typedef BOOL(^TextFieldShouldReturnBlock)(void);
typedef BOOL(^TextFieldShouldClearBlock)(void);

//man, welcome to the magic world of the flexible edit table view cell
//this cell could help you to manage any action of your UITextField (wow!)
@interface FlexibleEditTableViewCell : EditTableViewCell{
    ShouldChangeCharactersInRange _shouldChangeCharactersInRangeBlock;
    TextFieldShouldReturnBlock _textFieldShouldReturnBlock;
    TextFieldShouldClearBlock _textFieldShouldClearBlock;
    CalledBlock _textFieldDidBeginEditingBlock;
    CalledBlock _textFieldDidEndEditingBlock;
    
}

@property(readwrite, copy) ShouldChangeCharactersInRange shouldChangeCharactersInRangeBlock;
@property(readwrite, copy) TextFieldShouldReturnBlock textFieldShouldReturnBlock;
@property(readwrite, copy) TextFieldShouldClearBlock textFieldShouldClearBlock;
@property(readwrite, copy) CalledBlock textFieldDidBeginEditingBlock;
@property(readwrite, copy) CalledBlock textFieldDidEndEditingBlock;


@end
