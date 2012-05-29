//
//  FlexibleEditTableViewCell.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 12/12/11.
//

#import "FlexibleEditTableViewCell.h"

@implementation FlexibleEditTableViewCell
@synthesize shouldChangeCharactersInRangeBlock = _shouldChangeCharactersInRangeBlock;
@synthesize textFieldShouldReturnBlock = _textFieldShouldReturnBlock;
@synthesize textFieldShouldClearBlock = _textFieldShouldClearBlock;
@synthesize textFieldDidBeginEditingBlock = _textFieldDidBeginEditingBlock;
@synthesize textFieldDidEndEditingBlock = _textFieldDidEndEditingBlock;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(self.shouldChangeCharactersInRangeBlock){
        return self.shouldChangeCharactersInRangeBlock(range, string);
    }
    else{
        return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
    if(self.textFieldShouldReturnBlock){
        return self.textFieldShouldReturnBlock();
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.textFieldDidBeginEditingBlock){
        self.textFieldDidBeginEditingBlock();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(self.textFieldDidEndEditingBlock){
        self.textFieldDidEndEditingBlock();
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(self.textFieldShouldClearBlock){
        return self.textFieldShouldClearBlock();
    }
    return YES;
}

@end
